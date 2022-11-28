extends KinematicBody2D

onready var front_sprite = null
onready var back_sprite = null
onready var hp = 1000



export (Resource) var char_info = null

export (float) var movement_speed = 100.0

var last_movement = Vector2.UP
var level = 0
var experience = 0
var exp_to_next_level = 0
var gold

onready var sprite = $Sprite
onready var animate_sprite = $AnimateSpriteTimer

var sword = load("res://Scenes/Attack/SwordAttack.tscn")
var spell = load("res://Scenes/Attack/SpellCaster.tscn")
var spear = load("res://Scenes/Attack/SpearThrower.tscn")
var area = load("res://Scenes/Attack/AreaCaster.tscn")


var enemy_near = []


func _ready():
	front_sprite = char_info.front_sprite
	back_sprite = char_info.back_sprite
	level = char_info.level
	exp_to_next_level = exp_to_lvlup(level)
	print(char_info.weapon)
	match char_info.weapon:
		"sword":
			var weapon = sword.instance()
			add_child(weapon)
		"spell":
			var weapon = spell.instance()
			add_child(weapon)
		"spear":
			var weapon = spear.instance()
			add_child(weapon)
		"area":
			var weapon = area.instance()
			add_child(weapon)
	
	$GUI/Control/Label.text = str("Lvl: ",level)
	$GUI/Control/TextureProgress.max_value = exp_to_next_level
	$GUI/Control/TextureProgress.value = experience

func movement():
	var horizontal_move = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical_move = Input.get_action_strength("down") - Input.get_action_strength("up")
	var movement = Vector2(horizontal_move, vertical_move)
	
			
	if vertical_move >= 0:
		sprite.texture = front_sprite
	elif vertical_move < 0:
		sprite.texture = back_sprite
	
	if movement != Vector2.ZERO:
		last_movement = movement
		if animate_sprite.is_stopped():
			if sprite.frame >= sprite.hframes - 1:
				sprite.frame = 0
			else:
				sprite.frame+= 1
			animate_sprite.start()

	
	var velocity = movement.normalized()*movement_speed
	move_and_slide(velocity)
	
func _physics_process(delta):
	movement()


func _on_AnimateSpriteTimer_timeout():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/Player/test.tscn")


func _on_EnemyDetection_body_entered(body):
	if !enemy_near.has(body):
		enemy_near.append(body)


func _on_EnemyDetection_body_exited(body):
	if enemy_near.has(body):
		enemy_near.erase(body)

func get_target():
	if enemy_near.size()>0:
		return enemy_near[0].global_position
	else:
		return Vector2.UP

func get_enemy():
	if enemy_near.size()>0:
		return enemy_near[0]
	else:
		return null



func _on_HurtBox_hurt(damage, _angle, _knockback):
	hp-=damage
	print("Player hp: ",hp)


func exp_to_lvlup(level):
	return level*10


func _on_GrabLoot_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self


func _on_ColectLoot_area_entered(area):
	if area.is_in_group("loot"):
		var gem_exp = area.collected()
		experience+= gem_exp
	
		$GUI/Control/TextureProgress.value = experience
			
		print("Exp :", experience, " LVL :", level)
		if experience >= exp_to_next_level:
			level+=1
			var diff = experience - exp_to_next_level
			experience = diff
			exp_to_next_level = exp_to_lvlup(level)
			
			$GUI/Control/Label.text = str("Lvl: ",level)
			$GUI/Control/TextureProgress.max_value = exp_to_next_level
			$GUI/Control/TextureProgress.value = experience

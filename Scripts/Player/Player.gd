extends KinematicBody2D

onready var front_sprite = null
onready var back_sprite = null
onready var hp = 100
var armor = 0


var char_info = null

export (float) var movement_speed = 100.0

var last_movement = Vector2.UP
var level = 0
var experience = 0
var exp_to_next_level = 0
var gold = 0


var upgrades_lvl = {
	"sword":0, 
	"spell":0,
	"spear":0,
	"area":0,
	"health":0,
	"area_size":0,
	"boots":0,
	"armor":0
}


var upgrades = []

onready var sprite = $Sprite
onready var animate_sprite = $AnimateSpriteTimer

var sword = load("res://Scenes/Attack/SwordAttack.tscn")
var spell = load("res://Scenes/Attack/SpellCaster.tscn")
var spear = load("res://Scenes/Attack/SpearThrower.tscn")
var area = load("res://Scenes/Attack/AreaCaster.tscn")


var enemy_near = []


func _ready():
	char_info = PLAYER.Party_member
	
	front_sprite = char_info.front_sprite
	back_sprite = char_info.back_sprite
	level = char_info.level
	exp_to_next_level = exp_to_lvlup(level)
	print(char_info.weapon)
	match char_info.weapon:
		"sword":
			var weapon = sword.instance()
			add_child(weapon)
			upgrades.append("sword")
		"spell":
			var weapon = spell.instance()
			add_child(weapon)
			upgrades.append("spell")
		"spear":
			var weapon = spear.instance()
			add_child(weapon)
			upgrades.append("spear")
		"area":
			var weapon = area.instance()
			add_child(weapon)
			upgrades.append("area")
	upgrades_lvl[char_info.weapon]+=1
	print(upgrades_lvl[char_info.weapon])
	
	$GUI/Control/Label.text = str("Lvl: ",level)
	$GUI/Control/TextureProgress.max_value = exp_to_next_level
	$GUI/Control/TextureProgress.value = experience
	$GUI/Control/Money.text = str("Money : ",gold)

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
	print(hp)
	if hp <= 0:
		PLAYER.Money+= gold
		get_tree().change_scene("res://Scenes/World_map.tscn")


func exp_to_lvlup(level):
	return level*10


func _on_GrabLoot_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self


func _on_ColectLoot_area_entered(area):
	if area.is_in_group("loot"):
		if area.type == "exp":
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
				
				$GUI/LvlUp.popup_centered()
				for i in $GUI/LvlUp/VBoxContainer.get_children():
					i.get_option()
				get_tree().paused = true
				
		if area.type == "gold":
			var gold_gained = area.collected()
			gold += gold_gained
			$GUI/Control/Money.text = str("Money : ",gold)

func level_up(upgrade):
	if upgrade != "health":
		if upgrades.has(upgrade) and upgrades_lvl[upgrade] < 5:
			upgrades_lvl[upgrade]+=1
			update_stats()
		else:
			upgrades.append(upgrade)
	else:
		hp+=20
		hp = clamp(hp,hp,100)
	print(upgrades)

func update_stats():
	pass

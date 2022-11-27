extends KinematicBody2D

onready var front_sprite = null
onready var back_sprite = null

export (Resource) var char_info = null

export (float) var movement_speed = 100.0

var last_movement = Vector2.UP
var level = 0

onready var sprite = $Sprite
onready var animate_sprite = $AnimateSpriteTimer

var enemy_near = []


func _ready():
	front_sprite = char_info.front_sprite
	back_sprite = char_info.back_sprite
	level = char_info.level
	

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

func get_random_target():
	if enemy_near.size()>0:
		return enemy_near.pick_random().global_position
	else:
		return Vector2.UP

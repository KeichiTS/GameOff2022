extends KinematicBody2D

onready var front_sprite = null
onready var back_sprite = null

export (Resource) var char_info = null

export (float) var movement_speed = 100.0

onready var sprite = $Sprite
onready var animate_sprite = $AnimateSpriteTimer

func _ready():
	front_sprite = char_info.front_sprite
	back_sprite = char_info.back_sprite
	
	

func movement():
	var horizontal_move = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical_move = Input.get_action_strength("down") - Input.get_action_strength("up")
	var movement = Vector2(horizontal_move, vertical_move)
	
			
	if vertical_move >= 0:
		sprite.texture = front_sprite
	elif vertical_move < 0:
		sprite.texture = back_sprite
	
	if movement != Vector2.ZERO:
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

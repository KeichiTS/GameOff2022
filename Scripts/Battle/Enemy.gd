extends KinematicBody2D

export var hp = 1000

export var knockback_Recovery = 20

export var experience = 1

onready var player = null

export var enemy_movement := 20

var velocity = Vector2.ZERO

var knockBack = Vector2.ZERO

func _ready():
	$Label.text = str(hp)
	player = get_parent().find_node("Player",true)

	
func _process(delta):
	$Label.text = str(hp)

func _physics_process(delta):
	knockBack = knockBack.move_toward(Vector2.ZERO, knockback_Recovery)
	
	var direction = global_position.direction_to(player.global_position)
	#var direction = Vector2(5,-5)
	velocity = direction*enemy_movement
	velocity += knockBack

	

	
	move_and_slide(velocity)
	

func death():
	queue_free()

func _on_HurtBox_hurt(damage, angle, knockback):
	hp -= damage
	knockBack = -global_position.direction_to(player.global_position)*knockback
	if hp <= 0:
		death()

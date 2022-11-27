extends Area2D


onready var player = get_parent()
onready var collision = $CollisionShape2D
onready var sprite = $Sprite

var damage = 10
var knockback_amount = 100
var angle = Vector2.ZERO


func _physics_process(_delta):
	collision.position = sprite.position
	collision.rotation_degrees = sprite.rotation_degrees
	
	match player.last_movement:
		Vector2.UP:
			rotation_degrees = 180
		Vector2.DOWN:
			rotation_degrees = 0
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = 270	

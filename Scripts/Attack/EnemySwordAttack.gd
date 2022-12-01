extends Area2D

onready var player = get_parent()
onready var collision = $CollisionShape2D
onready var sprite = $Sprite
onready var animation = $AnimationPlayer

var damage = 10
var knockback_amount = 0
var angle = Vector2.ZERO

func _physics_process(_delta):
	collision.position = sprite.position
	collision.rotation_degrees = sprite.rotation_degrees

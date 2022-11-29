extends Area2D

var damage = 50
var area_size = 1
var speed = 1
onready var animation = $AnimationPlayer

func _ready():
	animation.playback_speed = speed


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

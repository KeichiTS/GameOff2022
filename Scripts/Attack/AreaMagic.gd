extends Area2D

var damage = 50

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

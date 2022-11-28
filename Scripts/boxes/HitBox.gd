extends Area2D

export var damage = 1

export var attack_rate = .5

onready var collision = $CollisionShape2D

onready var disalbetimer = $DisableTimer

func tempdisable():
	collision.call_deferred('set','disabled',true)
	disalbetimer.start()


func _on_DisableTimer_timeout():
	collision.call_deferred('set','disabled',false)

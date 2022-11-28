extends Area2D

export var gold = 10
export var type = "gold"
var target = null
var speed = -1

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position,speed)
		speed+= 2*delta

func collected():
	$CollisionShape2D.call_deferred("set","disabled",true)
	$Timer.start()
	return gold
	


func _on_Timer_timeout():
	queue_free()

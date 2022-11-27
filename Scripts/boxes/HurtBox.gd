extends Area2D

onready var collision = $CollisionShape2D
onready var disable_timer = $DisableTimer

export var disable_timer_amount = 0.2

signal hurt(damage, angle, knockback)

func _ready():
	disable_timer.wait_time = disable_timer_amount

func _on_HurtBox_area_entered(area):
	if area.is_in_group("attack"):
		if area.get("damage") != null:
			
			var damage = area.damage
			var angle = Vector2.ZERO
			var knockback = 1
			
			if area.get("angle") != null:
				angle = area.angle
			if area.get("knockback_amount") != null:
				knockback = area.knockback_amount
				
			emit_signal("hurt",damage, angle, knockback)
			print(damage)
			collision.call_deferred('set','disabled',true)
			disable_timer.start()
			print(damage)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)



func _on_DisableTimer_timeout():
	collision.call_deferred('set','disabled',false)


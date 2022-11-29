extends Area2D

onready var player = get_parent()
onready var collision = $CollisionShape2D
onready var sprite = $Sprite

var damage = 20
var knockback_amount = 0
var target = Vector2.ZERO
var angle = Vector2.ZERO
var attack_size = 1
var speed = 100
var hp = 1


func _ready():
	angle = position.direction_to(target)
	rotation = angle.angle() + deg2rad(-90)
	
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2(1,1)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()


func _physics_process(delta):
	position += angle*speed*delta
	
func enemy_hit(charge = 1):
	hp-=charge
	if hp < 0:
		queue_free()



func _on_Timer_timeout():
	queue_free()

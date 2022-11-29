extends Area2D


onready var player = get_parent()
onready var collision = $CollisionShape2D
onready var sprite = $Sprite

var damage = 10
var knockback_amount = 0
var angle = Vector2.ZERO
var target = null
var attack_size = 1
var speed = 300
var hp = 1


func _ready():
	
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2(1,1)*attack_size, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	

func _physics_process(delta):
	if is_instance_valid(target):
		angle = global_position.direction_to(target.global_position)
		position += angle*speed*delta
	else:
		queue_free()
	
func enemy_hit(charge = 1):
	hp-=charge
	if hp <= 0:
		
		queue_free()


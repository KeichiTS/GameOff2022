extends KinematicBody2D

export var hp = 1000

export var knockback_Recovery = 20
export var drag_force = .3

export var experience = 1

onready var player = null

onready var loot_base = null

export var enemy_movement := 50

var velocity = Vector2.ZERO

var knockBack = Vector2.ZERO

var exp_gem = preload("res://Scenes/Battle/ExpGem.tscn")
var gold_coin = preload("res://Scenes/Battle/GoldGem.tscn")


func _ready():
	player = get_parent().find_node("Player",true)
	loot_base = get_parent().find_node("Loot",true)
	
func _physics_process(delta):
	
	knockBack = knockBack.move_toward(Vector2.ZERO, knockback_Recovery)
	
	var direction = global_position.direction_to(player.global_position)
	#var direction = Vector2(5,-5)
	if direction.x > 0.1:
		$Sprite.flip_h = true
	elif direction.x < -0.1:
		$Sprite.flip_h = false
	
	var desired_velocity = direction*enemy_movement
	var sterring_velocity = desired_velocity - velocity
		
	velocity = direction*enemy_movement
	velocity += sterring_velocity*drag_force
	velocity += knockBack
	
	
	move_and_slide(velocity)
	



func _on_DamageTimer_timeout():
	$Sprite.material.set_shader_param("flash_modifer",0)


func _on_HurtBox_hurt(damage, angle, knockback):
	hp -= damage
	flash()
	knockBack = -global_position.direction_to(player.global_position)*knockback
	if hp <= 0:
		death()

func flash():
	$Sprite.material.set_shader_param("flash_modifer",1)
	$DamageTimer.start()
	
func death():
	var new_gem = exp_gem.instance()
	new_gem.global_position = global_position
	new_gem.experience = experience
	loot_base.call_deferred("add_child",new_gem)
	var new_gold = gold_coin.instance()
	new_gold.global_position = global_position + Vector2(rand_range(0,10),rand_range(0,10))*2 
	loot_base.call_deferred("add_child",new_gold)
	queue_free()

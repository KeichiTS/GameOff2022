extends KinematicBody2D

onready var front_sprite = null
onready var back_sprite = null
onready var hp = 100
var armor = 0
var area_size = 1

var char_info = null

export (float) var movement_speed = 100.0

var last_movement = Vector2.UP
var level = 0
var experience = 0
var exp_to_next_level = 0
var gold = 0


var upgrades_lvl = {
	"sword":0, 
	"spell":0,
	"spear":0,
	"area":0,
	"health":0,
	"boots":0,
	"armor":0
}


var upgrades = []

onready var sprite = $Sprite
onready var animate_sprite = $AnimateSpriteTimer

var sword = load("res://Scenes/Attack/SwordAttack.tscn")
var spell = load("res://Scenes/Attack/SpellCaster.tscn")
var spear = load("res://Scenes/Attack/SpearThrower.tscn")
var area = load("res://Scenes/Attack/AreaCaster.tscn")


var enemy_near = []


func _ready():
	
	$HealthBar.max_value = hp
	$HealthBar.value = hp
	char_info = PLAYER.Party_member
	
	front_sprite = char_info.front_sprite
	back_sprite = char_info.back_sprite
	level = char_info.level
	exp_to_next_level = exp_to_lvlup(level)
	print(char_info.weapon)
	match char_info.weapon:
		"sword":
			var weapon = sword.instance()
			add_child(weapon)
			upgrades.append("sword")
		"spell":
			var weapon = spell.instance()
			add_child(weapon)
			upgrades.append("spell")
		"spear":
			var weapon = spear.instance()
			add_child(weapon)
			upgrades.append("spear")
		"area":
			var weapon = area.instance()
			add_child(weapon)
			upgrades.append("area")
	upgrades_lvl[char_info.weapon]+=1
	print(upgrades_lvl[char_info.weapon])
	
	$GUI/Control/Label.text = str("Lvl: ",level)
	$GUI/Control/TextureProgress.max_value = exp_to_next_level
	$GUI/Control/TextureProgress.value = experience
	$GUI/Control/Money.text = str("Money : ",gold)

func movement():
	var horizontal_move = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical_move = Input.get_action_strength("down") - Input.get_action_strength("up")
	var movement = Vector2(horizontal_move, vertical_move)
	
			
	if vertical_move >= 0:
		sprite.texture = front_sprite
	elif vertical_move < 0:
		sprite.texture = back_sprite
	
	if movement != Vector2.ZERO:
		last_movement = movement
		if animate_sprite.is_stopped():
			if sprite.frame >= sprite.hframes - 1:
				sprite.frame = 0
			else:
				sprite.frame+= 1
			animate_sprite.start()

	
	var velocity = movement.normalized()*movement_speed
	move_and_slide(velocity)
	
func _physics_process(delta):
	movement()


func _on_AnimateSpriteTimer_timeout():
	pass # Replace with function body.




func _on_EnemyDetection_body_entered(body):
	if !enemy_near.has(body):
		enemy_near.append(body)


func _on_EnemyDetection_body_exited(body):
	if enemy_near.has(body):
		enemy_near.erase(body)

func get_target():
	if enemy_near.size()>0:
		return enemy_near[0].global_position
	else:
		return Vector2.UP

func get_enemy():
	if enemy_near.size()>0:
		return enemy_near[0]
	else:
		return null


func _on_HurtBox_hurt(damage, _angle, _knockback):
	var reduced_damage = clamp(damage - armor, 1, damage)
	hp-=reduced_damage
	$HealthBar.value = hp
	flash()
	print(hp)
	if hp <= 0:
		PLAYER.Money+= gold
		get_tree().change_scene("res://Scenes/World_map.tscn")

func flash():
	sprite.material.set_shader_param("flash_modifer",1)
	$DamageTimer.start()

func exp_to_lvlup(level):
	return level*10


func _on_GrabLoot_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self


func _on_ColectLoot_area_entered(area):
	if area.is_in_group("loot"):
		if area.type == "exp":
			var gem_exp = area.collected()
			experience+= gem_exp
		
			$GUI/Control/TextureProgress.value = experience
				
			print("Exp :", experience, " LVL :", level)
			if experience >= exp_to_next_level:
				level+=1
				var diff = experience - exp_to_next_level
				experience = diff
				exp_to_next_level = exp_to_lvlup(level)
				
				$GUI/Control/Label.text = str("Lvl: ",level)
				$GUI/Control/TextureProgress.max_value = exp_to_next_level
				$GUI/Control/TextureProgress.value = experience
				
				$GUI/LvlUp.popup_centered()
				for i in $GUI/LvlUp/VBoxContainer.get_children():
					i.get_option()
				get_tree().paused = true
				
		if area.type == "gold":
			var gold_gained = area.collected()
			gold += gold_gained
			$GUI/Control/Money.text = str("Money : ",gold)

func level_up(upgrade):

	if upgrade == "health":
		hp+=20
		hp = clamp(hp,hp,100)
		$HealthBar.value = hp
	elif upgrade != "health":
		upgrades_lvl[upgrade]+=1
		if upgrades_lvl[upgrade] < 5:
			update_stats(upgrade)
		if !upgrades.has(upgrade):
			upgrades.append(upgrade)
	
	print(upgrades)			


func update_stats(upgrade):
	match upgrade:
		"sword":
			match upgrades_lvl[upgrade]:
				1:
					if !upgrades.has(upgrade):
						var weapon = sword.instance()
						add_child(weapon)
				2:
					if get_node("SwordAttack"):
						var sword1 = get_node("SwordAttack")
						sword1.damage = 20
				3:
					if get_node("SwordAttack"):
						var sword1 = get_node("SwordAttack")
						sword1.damage = 50
						sword1.knockback_amount = 300
						sword1.animation.playback_speed = 1.5
				4:
					if get_node("SwordAttack"):
						var sword1 = get_node("SwordAttack")
						sword1.damage = 50
						sword1.knockback_amount = 300
						sword1.animation.playback_speed = 3
						sword1.scale = Vector2(1.5,1.5)
				5:
					if get_node("SwordAttack"):
						var sword1 = get_node("SwordAttack")
						sword1.damage = 100
						sword1.knockback_amount = 500
						sword1.animation.playback_speed = 5
						sword1.scale = Vector2(3,3)
		"spell":
			match upgrades_lvl[upgrade]:
				1:
					if !upgrades.has(upgrade):
						var weapon = spell.instance()
						add_child(weapon)
				2:
					if get_node("SpellCaster"):
						var spell1 = get_node("SpellCaster")
						
						spell1.spell_baseamo = 1
						spell1.spell_casttime = 2
						spell1.spell_charge_time = 1
						spell1.spell_damage = 30
						spell1.spell_knockback = 10
						
						
						
				3:
					if get_node("SpellCaster"):
						var spell1 = get_node("SpellCaster")
						
						spell1.spell_baseamo = 2
						spell1.spell_casttime = 2
						spell1.spell_charge_time = 1
						spell1.spell_damage = 30
						spell1.spell_knockback = 100
						spell1.spell_Size = 2
						
				4:
					if get_node("SpellCaster"):
						var spell1 = get_node("SpellCaster")
						spell1.spell_baseamo = 2
						spell1.spell_casttime = 1
						spell1.spell_charge_time = .2
						spell1.spell_damage = 100
						spell1.spell_knockback = 100
						spell1.spell_Size = 2
					
				5:
					if get_node("SpellCaster"):
						var spell1 = get_node("SpellCaster")
						spell1.spell_baseamo = 5
						spell1.spell_casttime = .5
						spell1.spell_charge_time = .2
						spell1.spell_damage = 100
						spell1.spell_knockback = 200
						spell1.spell_Size = 2
		"spear":
			match upgrades_lvl[upgrade]:
				1:
					if !upgrades.has(upgrade):
						var weapon = spear.instance()
						add_child(weapon)
				2:
					if get_node("SpearThrower"):
						var spell1 = get_node("SpearThrower")
						
						spell1.spell_baseamo = 1
						spell1.spell_casttime = 2
						spell1.spell_charge_time = 1
						spell1.spell_damage = 30
						spell1.spell_knockback = 10
				3:
					if get_node("SpearThrower"):
						var spell1 = get_node("SpearThrower")
						
						spell1.spell_baseamo = 2
						spell1.spell_casttime = 2
						spell1.spell_charge_time = 1
						spell1.spell_damage = 30
						spell1.spell_knockback = 10
						spell1.spear_speed = 150
				4:
					if get_node("SpearThrower"):
						var spell1 = get_node("SpearThrower")
						
						spell1.spell_baseamo = 5
						spell1.spell_casttime = 1
						spell1.spell_charge_time = 1
						spell1.spell_damage = 50
						spell1.spell_knockback = 10
						spell1.spell_hp = 2
						spell1.spear_speed = 250
				5:
					if get_node("SpearThrower"):
						var spell1 = get_node("SpearThrower")
						spell1.spell_baseamo = 5
						spell1.spell_casttime = .5
						spell1.spell_charge_time = .2
						spell1.spell_damage = 100
						spell1.spell_knockback = 200
						spell1.spell_Size = 2
						spell1.spell_hp = 5
						spell1.spear_speed = 350
		"area":
			match upgrades_lvl[upgrade]:
				1:
					if !upgrades.has(upgrade):
						var weapon = area.instance()
						add_child(weapon)
				2:
					if get_node("AreaCaster"):
						var areacaster = get_node("AreaCaster")
						areacaster.basecharges = 1
						areacaster.casttime = 5
						areacaster.chargetime = 5
						areacaster.speed = 1
						areacaster.area_size = 2
						areacaster.damage = 50
				3:
					if get_node("AreaCaster"):
						var areacaster = get_node("AreaCaster")
						areacaster.basecharges = 5
						areacaster.casttime = 2
						areacaster.chargetime = 2
						areacaster.speed = .8
						areacaster.area_size = 2
						areacaster.damage = 50
				4:
					if get_node("AreaCaster"):
						var areacaster = get_node("AreaCaster")
						areacaster.basecharges = 5
						areacaster.casttime = 2
						areacaster.chargetime = 2
						areacaster.speed = .5
						areacaster.area_size = 2
						areacaster.damage = 100
				5:
					if get_node("AreaCaster"):
						var areacaster = get_node("AreaCaster")
						areacaster.basecharges = 5
						areacaster.casttime = 2
						areacaster.chargetime = 2
						areacaster.speed = .3
						areacaster.area_size = 4
						areacaster.damage = 100
		
		"boots":
			match upgrades_lvl[upgrade]:
				1:
					movement_speed = 110
				2:
					movement_speed = 120
				3:
					movement_speed = 150
				4:
					movement_speed = 200
				5:
					movement_speed = 250
		"armor":
			match upgrades_lvl[upgrade]:
				1:
					armor = 1
				2:
					armor = 2
				3:
					armor = 3
				4:
					armor = 4
				5:
					armor = 5


func _on_DamageTimer_timeout():
	sprite.material.set_shader_param("flash_modifer",0)

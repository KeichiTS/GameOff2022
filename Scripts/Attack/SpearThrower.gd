extends Node2D

onready var player = get_parent()

#Aqui veio a preguiça de trocar spell por spear
var spell = preload("res://Scenes/Attack/Spear.tscn")

var spell_level = 1
var spell_ammo = 1
var spell_baseamo = 1
var spell_casttime = 2
var spell_charge_time = 1
var spell_damage = 10
var spell_knockback = 0
var spell_Size = 1
var spell_hp = 1
var spear_speed = 100

func _ready():
	cast()

func cast():
	$ThrowTimer.wait_time = spell_casttime
	$ChargeTimer.wait_time = spell_charge_time
	$ThrowTimer.start()
	$ChargeTimer.start()

func _physics_process(delta):
	position = player.position





func _on_ChargeTimer_timeout():
	if spell_ammo < spell_baseamo:
		spell_ammo+=1
		


func _on_ThrowTimer_timeout():
	if spell_ammo > 0:
		var spellcast = spell.instance()
		spellcast.player = player
		spellcast.target = player.get_target()
		spellcast.position = position
		spellcast.knockback_amount = spell_knockback
		spellcast.attack_size = spell_Size
		spellcast.damage = spell_damage
		spellcast.hp = spell_hp
		spellcast.speed = spear_speed
		
		add_child(spellcast)
		spellcast.set_as_toplevel(true)
		spell_ammo-=1

	

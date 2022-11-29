extends Node2D

onready var player = get_parent()
var spell = preload("res://Scenes/Attack/Spell.tscn")


var spell_level = 1
var spell_ammo = 1
var spell_baseamo = 1
var spell_casttime = 2.5
var spell_charge_time = 1
var spell_damage = 10
var spell_knockback = 0
var spell_Size = 1


func _ready():
	cast()

func cast():
	$CastTime.wait_time = spell_casttime
	$ChargeTime.wait_time = spell_charge_time
	$CastTime.start()
	$ChargeTime.start()

func _physics_process(delta):
	position = player.position


func _on_CastTime_timeout():
	if spell_ammo > 0 and player.get_enemy() != null:
		var spellcast = spell.instance()
		spellcast.knockback_amount = spell_knockback
		spellcast.attack_size = spell_Size
		spellcast.damage = spell_damage
		spellcast.position = position
		spellcast.target = player.get_enemy()
		spellcast.player = player
		add_child(spellcast)
		spellcast.set_as_toplevel(true)
		spell_ammo-=1

func _on_ChargeTime_timeout():
	if spell_ammo < spell_baseamo:
		spell_ammo+=1
		

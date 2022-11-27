extends Node2D

onready var player = get_parent()
var spell = preload("res://Scenes/Attack/Spell.tscn")

var spell_level = 1
var spell_ammo = 0
var spell_baseamo = 1
var spell_casttime = 1.5


func _ready():
	cast()

func cast():
	$CastTime.wait_time = spell_casttime
	$CastTime.start()
	$ChargeTime.start()

func _physics_process(delta):
	position = player.position


func _on_CastTime_timeout():
	if spell_ammo > 0 and player.get_enemy() != null:
		var spellcast = spell.instance()
		spellcast.position = position
		spellcast.target = player.get_enemy()
		spellcast.player = player
		add_child(spellcast)
		spellcast.set_as_toplevel(true)
		spell_ammo-=1

func _on_ChargeTime_timeout():
	if spell_ammo < spell_baseamo:
		spell_ammo+=1
		

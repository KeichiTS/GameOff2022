extends Node2D

onready var player = get_parent()

#Aqui veio a preguiça de trocar spell por spear
var spell = preload("res://Scenes/Attack/Spear.tscn")

var spell_level = 1
var spell_ammo = 1
var spell_baseamo = 1
var spell_casttime = .2


func _ready():
	cast()

func cast():
	$ThrowTimer.wait_time = spell_casttime
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
		add_child(spellcast)
		spellcast.set_as_toplevel(true)
		spell_ammo-=1

	

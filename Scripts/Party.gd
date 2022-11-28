extends Node


onready var party_member = get_parent().get_node("HUD/PartyMember")

func _ready():
	party_member.text = PLAYER.Party_member.name


func _on_Warrior_pressed():
	PLAYER.Party_member = load("res://Resources/Warrior.tres")
	party_member.text = PLAYER.Party_member.name


func _on_Mage_pressed():
	PLAYER.Party_member = load("res://Resources/Mage.tres")
	party_member.text = PLAYER.Party_member.name

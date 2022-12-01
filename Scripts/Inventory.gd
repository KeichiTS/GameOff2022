extends Node


func _ready():
	$HUD/Money.text = "Money: " + str(PLAYER.Money)
	$HUD/EXP.text = "EXP: " + str(PLAYER.EXP)


func _on_Return_pressed():
	get_tree().change_scene("res://Scenes/World_map.tscn")


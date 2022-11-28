extends Node

func _ready():
	$HUD/Level.text = "Level: " + str(PLAYER.Level)
	$HUD/HP.text = "HP: " + str(PLAYER.HP)
	$HUD/Money.text = "Money: " + str(PLAYER.Money)
	$HUD/EXP.text = "EXP: " + str(PLAYER.EXP)
	$HUD/Damage.text = "Damage: " + str(PLAYER.Damage)


func _on_Adventure_pressed():
	get_tree().change_scene("res://Scenes/Battle/BattleGround.tscn")


func _on_Upgrades_pressed():
	get_tree().change_scene("res://Scenes/Upgrades.tscn")


func _on_Shop_pressed():
	get_tree().change_scene("res://Scenes/Shop.tscn")


func _on_Inventory_pressed():
	get_tree().change_scene("res://Scenes/Inventory.tscn")

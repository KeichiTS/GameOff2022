extends Node

var on_dialog = true 

func _ready():
	$HUD/Money.text = "Money: " + str(PLAYER.Money)
	$HUD/EXP.text = "EXP: " + str(PLAYER.EXP)


#	if on_dialog == true:
#		$Buttons/Adventure.disabled = true
#		$Buttons/Inventory.disabled = true
#		$Buttons/Shop.disabled = true
#		$Buttons/Upgrades.disabled = true 

func _on_Adventure_pressed():
	get_tree().change_scene("res://Scenes/Battle/BattleGround.tscn")


func _on_Upgrades_pressed():
	get_tree().change_scene("res://Scenes/Upgrades.tscn")


func _on_Shop_pressed():
	get_tree().change_scene("res://Scenes/Shop.tscn")


func _on_Inventory_pressed():
	get_tree().change_scene("res://Scenes/Inventory.tscn")


func active_buttons(): 
		$Buttons/Adventure.disabled = false
		$Buttons/Inventory.disabled = false
		$Buttons/Shop.disabled = false
		$Buttons/Upgrades.disabled = false

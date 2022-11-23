extends Node


func _ready():
	$HUD/Level.text = "Level: " + str(PLAYER.Level)
	$HUD/HP.text = "HP: " + str(PLAYER.HP)
	$HUD/Money.text = "Money: " + str(PLAYER.Money)
	$HUD/EXP.text = "EXP: " + str(PLAYER.EXP)
	$HUD/Damage.text = "Damage: " + str(PLAYER.Damage)

	if PLAYER.Equip1 == true:
		$Buttons/Equip_1.disabled
		$Buttons/Equip_1.visible = false
	
	if PLAYER.Equip2 == true:
		$Buttons/Equip_2.disabled
		$Buttons/Equip_2.visible = false
	
	if PLAYER.Equip3 == true:
		$Buttons/Equip_3.disabled
		$Buttons/Equip_3.visible = false

func _on_Return_pressed():
	get_tree().change_scene("res://Scenes/World_map.tscn")


func _on_Equip_1_pressed():
	if PLAYER.Buy_Equip1 == true:
		PLAYER.Equip1 = true
		$Buttons/Equip_1.disabled
		$Buttons/Equip_1.visible = false


func _on_Equip_2_pressed():
	if PLAYER.Buy_Equip2 == true:
		PLAYER.Equip2 = true
		$Buttons/Equip_2.disabled
		$Buttons/Equip_2.visible = false

func _on_Equip_3_pressed():
	if PLAYER.Buy_Equip3 == true:
		PLAYER.Equip3 = true
		$Buttons/Equip_3.disabled
		$Buttons/Equip_3.visible = false

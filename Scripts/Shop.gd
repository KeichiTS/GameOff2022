extends Node


func _ready():
	$HUD/Level.text = "Level: " + str(PLAYER.Level)
	$HUD/HP.text = "HP: " + str(PLAYER.HP)
	$HUD/Money.text = "Money: " + str(PLAYER.Money)
	$HUD/EXP.text = "EXP: " + str(PLAYER.EXP)
	$HUD/Damage.text = "Damage: " + str(PLAYER.Damage)
	
	if PLAYER.Buy_Equip1 == true:
		$Buttons/Buy_1.disabled
		$Buttons/Buy_1.visible = false
		
	if PLAYER.Buy_Equip2 == true:
		$Buttons/Buy_2.disabled
		$Buttons/Buy_2.visible = false
		
		
	if PLAYER.Buy_Equip3 == true:
		$Buttons/Buy_3.disabled
		$Buttons/Buy_3.visible = false
		
func _on_Return_pressed():
	get_tree().change_scene("res://Scenes/World_map.tscn")


func _on_Buy_1_pressed():
	if PLAYER.Money >= 100:
		PLAYER.Money -= 100
		$Buttons/Buy_1.disabled
		PLAYER.Buy_Equip1 = true
		$Buttons/Buy_1.visible = false
		$HUD/Money.text = "Money: " + str(PLAYER.Money)


func _on_Buy_2_pressed():
	if PLAYER.Money >= 200:
		PLAYER.Money -= 200
		$Buttons/Buy_2.disabled
		PLAYER.Buy_Equip2 = true
		$Buttons/Buy_2.visible = false
		$HUD/Money.text = "Money: " + str(PLAYER.Money)

func _on_Buy_3_pressed():
	if PLAYER.Money >= 300:
		PLAYER.Money -= 300
		$Buttons/Buy_3.disabled
		PLAYER.Buy_Equip3 = true
		$Buttons/Buy_3.visible = false
		$HUD/Money.text = "Money: " + str(PLAYER.Money)

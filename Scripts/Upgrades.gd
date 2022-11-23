extends Node


func _ready():
	$HUD/Level.text = "Level: " + str(PLAYER.Level)
	$HUD/HP.text = "HP: " + str(PLAYER.HP)
	$HUD/Money.text = "Money: " + str(PLAYER.Money)
	$HUD/EXP.text = "EXP: " + str(PLAYER.EXP)
	$HUD/Damage.text = "Damage: " + str(PLAYER.Damage)


func _on_Upgrade_pressed():
	if PLAYER.EXP >= 100:
		PLAYER.EXP -= 100
		PLAYER.Level += 1 
		PLAYER.Damage += 1
		PLAYER.HP += 1
		$HUD/Level.text = "Level: " + str(PLAYER.Level)
		$HUD/HP.text = "HP: " + str(PLAYER.HP)
		$HUD/EXP.text = "EXP: " + str(PLAYER.EXP)
		$HUD/Damage.text = "Damage: " + str(PLAYER.Damage)


func _on_Return_pressed():
	get_tree().change_scene("res://Scenes/World_map.tscn")

extends Node

var enemy_hp = 100


func _ready():
	$HUD/Level.text = "Level: " + str(PLAYER.Level)
	$HUD/HP.text = "HP: " + str(PLAYER.HP)
	$HUD/Money.text = "Money: " + str(PLAYER.Money)
	$HUD/EXP.text = "EXP: " + str(PLAYER.EXP)
	$HUD/Damage.text = "Damage: " + str(PLAYER.Damage)


	$Enemy_HP/Life.text = "Enemy HP: " + str(enemy_hp)

func _on_Do_dammage_pressed():
	if enemy_hp > 0:  
		enemy_hp -= PLAYER.Damage
		if PLAYER.Equip1 == true:
			enemy_hp -= 10
		if PLAYER.Equip2 == true:
			enemy_hp -= 20
		if PLAYER.Equip3 == true:
			enemy_hp -= 30
			
			
			
		$Enemy_HP/Life.text = "Enemy HP: " + str(enemy_hp)
		if enemy_hp <= 0:
			enemy_hp = 0 
			$Enemy_HP/Life.text = "Enemy Defeated"
			PLAYER.EXP += 100
			PLAYER.Money += 100
			$HUD/Money.text = "Money: " + str(PLAYER.Money)
			$HUD/EXP.text = "EXP: " + str(PLAYER.EXP)


func _on_Return_pressed():
	get_tree().change_scene("res://Scenes/World_map.tscn")

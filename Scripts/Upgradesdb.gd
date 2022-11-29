extends Node

var upgrades  = [
	"sword", 
	"spell",
	"spear",
	"area",
	"health",
	"boots",
	"armor"
]




func choose_upgrade(player, player_upgrades : Array):

	randomize()	
	var possible_upgrades = upgrades
	possible_upgrades.shuffle()
	var upgrade = possible_upgrades[0]
	

	if player_upgrades.size() < 4:
		return upgrade
		
	else:
		var possible_updates2 = ["health"]
		for itens in player_upgrades:
			possible_updates2.append(itens)
		possible_updates2.shuffle()
		upgrade = possible_updates2[0]
				
		return upgrade


func _on_Button_pressed():
	PLAYER.Level += 1 
	$HUD/Level.text = "Level: " + str(PLAYER.Level)


func _on_Button2_pressed():
	get_tree().change_scene("res://Scenes/World_map.tscn")

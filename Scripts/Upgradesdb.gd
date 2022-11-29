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
		possible_upgrades = player_upgrades
		possible_upgrades.append("health")
		possible_upgrades.shuffle()
		upgrade = possible_upgrades[0]
				
		return upgrade

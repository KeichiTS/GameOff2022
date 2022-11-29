extends Node

var upgrades  = [
	"sword", 
	"spell",
	"spear",
	"area",
	"area_size",
	"health",
	"boots",
	"armor"
]



func choose_upgrade(player, player_upgrades : Array):

	randomize()	
	var possible_upgrades = upgrades
	possible_upgrades.shuffle()
	var upgrade = possible_upgrades[0]
	
	if player.upgrades_lvl[upgrade] >= 5:
		possible_upgrades.erase(upgrade)
		upgrade = "health"		
	
	if player_upgrades.size() < 4:
		return upgrade
		
	else:
		player_upgrades.shuffle()
		upgrade = player_upgrades[0]
		if !player.upgrades_lvl[player_upgrades[0]] < 5:
			player_upgrades.shuffle()
		upgrade = player_upgrades[0]
		
		return upgrade
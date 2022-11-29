extends Button

#ugly
onready var player = get_parent().get_parent().get_parent().get_parent()
onready var popup = get_parent().get_parent()
var upgrade_to_choose = ""

func _ready():


	print(player, popup)


func get_option():
	#var upgrade = UPgrades.choose_upgrade(player, player.upgrades)
	var upgrade = UPgrades.choose_upgrade(player, player.upgrades)
	if player.upgrades_lvl[upgrade] >= 5:
		upgrade = "health"
	text = upgrade
	upgrade_to_choose = upgrade

func _on_Opt_pressed():
	player.level_up(upgrade_to_choose)
	upgrade_to_choose = ""
	popup.hide()
	get_tree().paused = false

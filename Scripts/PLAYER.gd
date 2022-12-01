extends Node


#Game Values
var EXP = 300
var Money = 600

#Warrior values
var Level1 = 1
var HP1 = 100
var Damage1 = 1
var Speed1 = 100

#Mage Values
var Level2 = 1
var HP2 = 100
var Damage2 = 1
var Speed2 = 100

var Party_member : CharInfo = load("res://Resources/Warrior.tres")

#Equip values
var Equip1 = false
var Equip2 = false
var Equip3 = false

#Shop values
var Buy_Equip1 = false
var Buy_Equip2 = false
var Buy_Equip3 = false

#Dialog values
var dialog_to_show = 0 
var dialog_showed = 0 

func _ready():
	pass

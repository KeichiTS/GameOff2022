extends Control

export (Resource) var char_info = null

func _ready():
	$Label.text = str("level :",char_info.level)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/Player/Player.tscn")
		

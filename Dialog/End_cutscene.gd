extends Control

onready var dialog = [
	"Bola de fogo acabou com a vila!",
	"Não tivemos uma boa idéia para estória e o jogo acaba aqui",
	"Thau!"
]


var dialog_index = 0
var finished = false
var counter = 0 

	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()
		counter += 1 
	if counter == 4:
		get_tree().change_scene("res://MainMenu/MainMenu.tscn")
		

	
func load_dialog():
	if dialog_index < dialog.size():
		
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
		
	dialog_index += 1




func _on_Tween_tween_completed(object, key):
	finished = true

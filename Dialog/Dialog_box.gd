extends Control

onready var text1 = [
	"Linha 1",
	"Linha 2",
	"Linha 3",
	"Linha 4",
	"Linha 5",
	"Linha 6",
	"Linha 7"
]

onready var text2 = [
	"Linha 8",
	"Linha 9",
	"Linha 10",
	"Linha 11",
	"Linha 12",
	"Linha 13",
	"Linha 14"
]

###############

var dialog_index = 0
var finished = false
var counter = 0
var timeout = true 
var dialog 


func _ready():
	queue_free() ###APAGAR AQUI QUANDO FOR USAR O DIALOGO



#	if PLAYER.Level >= 10 and PLAYER.Level <= 20:
#		PLAYER.dialog_to_show = 1

#	if PLAYER.dialog_to_show == 0 and PLAYER.dialog_showed == 0:
#		dialog = text1
#		PLAYER.dialog_showed = 1
		
#	elif PLAYER.dialog_to_show == 1 and PLAYER.dialog_showed == 1:
#		dialog = text2
#		PLAYER.dialog_showed = 2
#	else:
#		get_parent().on_dialog = false
#		get_parent().active_buttons()
#		queue_free()
	pass

func _process(delta):

	if counter == 0 :
		timeout = false
		load_dialog()
		counter += 1 
		$wait_timer.start()
		
	
	if Input.is_action_just_pressed("ui_accept") and counter <= len(dialog) and timeout == true:
		timeout = false
		load_dialog()
		counter += 1
		$wait_timer.start()
		
		
	if counter >= len(dialog) + 1:
		get_parent().on_dialog = false
		get_parent().active_buttons()
		queue_free()


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


func _on_wait_timer_timeout():
	timeout = true

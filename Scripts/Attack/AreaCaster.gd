extends Node2D

var charges = 0
var basecharges = 1
var casttime = 5
var chargetime = 5

var area_to_Cast = preload("res://Scenes/Attack/AreaMagic.tscn")

func _ready():
	randomize()
	cast()

func cast():
	$CastTimer.wait_time = casttime
	$ChargeTimer.wait_time = chargetime
	$CastTimer.start()
	$ChargeTimer.start()

func _on_ChargeTimer_timeout():
	if charges < basecharges:
		charges+=1


func _on_CastTimer_timeout():
	if charges > 0:
		var vpr = get_viewport_rect().size * rand_range(.1, .8)
		var posx = vpr.x
		var posy = vpr.y
		
		var area = area_to_Cast.instance()
		area.position = Vector2(posx, posy)
		add_child(area)
		area.set_as_toplevel(true)
		charges-=1

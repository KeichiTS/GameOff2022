extends Node2D

export (Array, Resource) var spawns = []

onready var player = get_parent().get_node("Player")

var time = 0

func _ready():
	print(spawns[0])




func _on_Time_timeout():
	time+=1
	var enemy_spawn = spawns
	for enemy in enemy_spawn:
		if time > enemy.time_start and time < enemy.time_end:
			if enemy.spwan_delay < enemy.enemy_delay:
				enemy.spwan_delay+=1
			else:
				enemy.spwan_delay = 0
				var new_enemy = enemy.enemy
				for i in enemy.enemy_number:
					var enemy_to_spawn = new_enemy.instance()
					#enemy_to_spawn.player = player
					enemy_to_spawn.global_position = get_random_pos()
					get_parent().add_child(enemy_to_spawn)

func get_random_pos(up = true, down = true, left = true, right = true):
	var vpr = get_viewport_rect().size * rand_range(1.1, 1.4)
	var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
	var pos_side = []
	if up:
		pos_side.append("up")
	if down:
		pos_side.append("down")
	if right:
		pos_side.append("right")
	if left:
		pos_side.append("left")
	
	var get_rand = randi() % pos_side.size()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side[get_rand]:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = Vector2(bottom_right.x, top_left.y)
		"down":
			spawn_pos1 = Vector2(top_left.x, bottom_right.y)
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = Vector2(bottom_right.x, top_left.y)
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = Vector2(top_left.x, bottom_right.y)
	
	var x_spawn = rand_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = rand_range(spawn_pos2.y, spawn_pos2.y)
	return Vector2(x_spawn,y_spawn)

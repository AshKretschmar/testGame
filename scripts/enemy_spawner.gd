extends Node2D

signal enemy_spawned(enemy_instance)
signal path_enemy_spawned(path_enemy_instance)

var enemy_scene = preload("res://scenes/enemy.tscn")
var path_enemy_scene = preload("res://scenes/path_enemy.tscn")

#references SpawnPoisitons node
@onready var spawn_positions = $SpawnPositions

func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	#return a list of nodes that SpawnPositions node contains
	#In this case it is 6 Marker2D nodes
	#Put it inside a new variable so we can call pick_random() to pick a random element in the array
	var spawn_positions_array = spawn_positions.get_children()
	var random_spawn_position = spawn_positions_array.pick_random()
	
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = random_spawn_position.global_position
	emit_signal("enemy_spawned", enemy_instance)
	#add_child(enemy_instance)


func _on_timer_2_timeout():
	spawn_path_enemy()

func spawn_path_enemy():
	var path_enemy_instance = path_enemy_scene.instantiate()
	emit_signal("path_enemy_spawned", path_enemy_instance)

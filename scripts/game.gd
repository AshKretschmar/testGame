extends Node2D

var lives = 3
var score = 0


#references the player
@onready var player = $Player
@onready var hud = $UI/HUD
@onready var ui = $UI

@onready var enemy_hit_sound = $EnemyHitSound
@onready var player_dmg_sound = $PlayerDmgSound

#now I have the game over scene file so I can instantiate it 
var gameover_scene = preload("res://scenes/game_over_screen.tscn")

func _ready():
	hud.set_score_label(score)
	hud.set_lives(lives)

func _on_deathzone_area_entered(area):
	area.queue_free()


func _on_player_took_damage():
	lives -= 1
	score -= 100
	player_dmg_sound.play()
	hud.set_lives(lives)
	if lives == 0:
		#print("Game Over")
		player.die()
		
		#this starts a timer before our game over screen pops up after player death
		await get_tree().create_timer(1.5).timeout
		
		#instatiate game over screen & update it's score
		var gos = gameover_scene.instantiate()
		gos.set_score(score)
		#we @onready ui so we can add the game over screen here
		ui.add_child(gos)
	


func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

#called every time an enemy dies
func _on_enemy_died():
	score += 100
	#print(score)
	hud.set_score_label(score)
	enemy_hit_sound.play()


func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)

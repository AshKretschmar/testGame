extends CharacterBody2D


#CUSTOM SIGNAL
signal took_damage


var speed = 400

#loads a packed scene. use preload instead of load to load it once at the beginning of the game
#I use this in the shoot() function which instantiates the scene and adds it to the player when they hit spacebar
var rocket_scene = preload("res://scenes/rocket.tscn")

#identical to using _ready() function
@onready var rocket_container = $RocketContainer #<--identical to get_node("RocketContainer")

@onready var rocket_laser_sound = $RocketLaser

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
		


func _physics_process(delta):
	#set velocity to 0 every frame
	#Now when you let go of the move key the player stops moving
	velocity = Vector2(0,0)
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed
	if Input.is_action_pressed("move_down"):
		velocity.y = speed
		
	move_and_slide()
	
	#This code keeps the player inside of the viewport of the game
	var screen_size = get_viewport_rect().size
#	if global_position.x < 0:
#		global_position.x = 0
#	if global_position.x > screen_size.x:
#		global_position.x = screen_size.x
#	if global_position.y < 0:
#		global_position.y = 0
#	if global_position.y > screen_size.y:
#		global_position.y = screen_size.y
#
#	print(global_position)
	
	#This code does the same as the above commented if statements
	#clampf: Clamps the value, returning a float not less than min and not more than max.
#	global_position.x = clampf(global_position.x, 50, (screen_size.x -50 ))	
#	global_position.y = clampf(global_position.y, 50 , (screen_size.y - 50))
	
	#does the above 2 lines in 1 line (I had less control over how the player overlaps at the edges though)
	global_position = global_position.clamp(Vector2(0,0), screen_size)
	


func shoot():
	
	#creates a new instance of rocket scene
	var rocket_instance = rocket_scene.instantiate()
	
	#finally add the instance to the scene, now when we hit spacebar it will add it to our player
	#add_child(rocket_instance)
	#this line instead adds the rocket instances to the rocket container, so they are not affected by the players movement
	rocket_container.add_child(rocket_instance)
	
	#setting the instances global position to the players global position
	#the RocketContainer doesn't have a position, thats why we need to set its position
	#if we don't the rocket spawns at the origin 0,0
	rocket_instance.global_position = global_position
	#move the position of the rocket so it doesnt spawn on top of the ship and instead spawns in front of it
	rocket_instance.global_position.x += 75
	
	rocket_laser_sound.play()

func take_damage():
	#print("player took damage")
	emit_signal("took_damage")

func die():
	queue_free()

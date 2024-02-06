extends Area2D

#@export creates variable in the Inspector for easy adjustment --->
@export var speed = 300
#create reference to the VisibleOnScreenNotifier Node 
@onready var visible_notifier = $VisibleNotifier

func _ready():
	visible_notifier.connect("screen_exited", _on_screen_exited)

func _physics_process(delta):
	
	#move rocket +px every frame on x axis
	#increments global position by the speed every frame
	#meaning a higher framerate will make player speed faster than a lower framerate, we dont want this
	#global_position.x += speed
	#instead we are going to multiply speed by delta to decide how fast we want our rocket to move per second instead of per frame
	global_position.x += speed*delta
	#print(speed*delta) #prints amount of pixels moved each second
	#Anyways the whole point is we want consistent behavior across different framerates, thats why we use delta time

func _on_screen_exited():
	#print("Rocket exited screen")
	#this function deleted the node on screen exit
	queue_free()

#called when an area(enemy) enters the rockets area
func _on_area_entered(area):
	#print(area.name)
	queue_free()
	area.die()  

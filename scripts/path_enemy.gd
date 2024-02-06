extends Path2D

#rference to PathFollow2D and Enemy
@onready var pathfollow = $PathFollow2D
@onready var enemy = $PathFollow2D/Enemy

func _ready():
	pathfollow.set_progress_ratio(1)

func _process(delta):
	#-.25 from progress ratio each second
	#remember to multiply by delta so that it is not frame dependent
	pathfollow.progress_ratio -= 0.25 * delta
	if pathfollow.progress_ratio <= 0:
		queue_free()

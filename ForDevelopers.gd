extends KinematicBody2D

const SPEED = 100

var motion = Vector2()
var dir = 0

func _process(delta):
	if position.x > 850:
		dir = 1
	if position.x < 160:
		dir = 0
#	pass

func _physics_process(delta):
	if dir == 0:
		motion.x = SPEED
	else:
		motion.x = -SPEED	
	
	move_and_slide(motion)
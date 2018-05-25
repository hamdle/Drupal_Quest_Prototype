extends KinematicBody2D

const STEP = 0.8
const BOUNCE_HEIGHT = 14
var bounce = 0
var bounce_dir = 0
var motion = Vector2()

func _physics_process(delta):
	if bounce_dir == 0:
		bounce += STEP
	if bounce_dir == 1:
		bounce -= STEP
		
	if bounce > BOUNCE_HEIGHT:
		bounce_dir = 1
	if bounce < -BOUNCE_HEIGHT:
		bounce_dir = 0
	
	motion.y = bounce
	
	move_and_slide(motion)

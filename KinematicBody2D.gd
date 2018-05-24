extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 15
const ACCELERATION = 72
const MAX_SPEED = 300
const JUMP_HEIGHT = 475
const JETPACK_HEIGHT = 300

var motion = Vector2()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _physics_process(delta):
	# Gravity
	motion.y += GRAVITY
	var friction = false
	
	# Controls
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
	else:
		friction = true
	
	var on_floor = is_on_floor()
	if Input.is_action_just_pressed("ui_up"):
		if on_floor == true:
			motion.y = -JUMP_HEIGHT
		else:
			motion.y = -JETPACK_HEIGHT
	
	if on_floor == true:
		if friction:
			motion.x = lerp(motion.x, 0, 0.5)

				
	# Kinematic body movement
	motion = move_and_slide(motion, UP)

extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 15
const ACCELERATION = 50
const MAX_SPEED = 300
const JUMP_HEIGHT = 400
const MAX_LAUNCH = 800

var motion = Vector2()
var launch_timer = 0
var launch = false

func _ready():

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
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_HEIGHT
		if friction:
			motion.x = lerp(motion.x, 0, 0.5)
	
	if launch == true:
		if is_on_floor():
			print("Launching: " + String(launch_timer) + " Actual launch of: " + String(min(launch_timer, 1000)))
			motion.y = -min(launch_timer, 1000)
			launch = false
			launch_timer = 0
					
	# Kinematic body movement
	motion = move_and_slide(motion, UP)

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		launch_timer = OS.get_ticks_msec()
	if Input.is_action_just_released("ui_down"):
		launch_timer = OS.get_ticks_msec() - launch_timer
		launch = true
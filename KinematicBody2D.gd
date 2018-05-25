extends KinematicBody2D

# Physics and Jump
const UP = Vector2(0, -1)
const GRAVITY = 10
const ACCELERATION = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = 300
const MAX_LAUNCH = 700

var motion = Vector2()
var launch_timer = 0
var launch = false

func _process(delta):
	pass

func _physics_process(delta):
	# Gravity
	motion.y += GRAVITY
	var friction = false
	
	# Controls
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$KinematicBody2D/Sprite.flip_h = false
		if get_floor_velocity().x > 0:
			motion.x += get_floor_velocity().x 
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$KinematicBody2D/Sprite.flip_h = true
		if get_floor_velocity().x < 0:
			motion.x += get_floor_velocity().x
	else:
		friction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_HEIGHT
		if friction:
			motion.x = lerp(motion.x, 0, 0.5)
	
	if launch == true:
		if is_on_floor():
			print("Launching: " + String(launch_timer) + " Actual launch of: " + String(min(launch_timer, MAX_LAUNCH)))
			motion.y = -min(launch_timer, MAX_LAUNCH)
			launch = false
			launch_timer = 0
	
	motion = move_and_slide(motion, UP)

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		launch_timer = OS.get_ticks_msec()
	if Input.is_action_just_released("ui_down"):
		launch_timer = OS.get_ticks_msec() - launch_timer
		launch = true
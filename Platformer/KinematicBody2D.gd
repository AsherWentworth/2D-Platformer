extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 250
const MAX_JUMP = -550
const RUN_MULT = 1.25

var SPEED = MAX_SPEED
var JUMP = MAX_JUMP

var motion = Vector2()

# warning-ignore:unused_argument
func _physics_process(delta):
	
	var friction = false
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_down"): #bonus function: n-key rollover test
		SPEED = MAX_SPEED * RUN_MULT
		JUMP = MAX_JUMP * RUN_MULT
	else:
		SPEED = MAX_SPEED
		JUMP = MAX_JUMP
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		motion.x = lerp(motion.x, 0, 0.25)
		friction = true
		$Sprite.play("Idle")
	
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.25)
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	
	motion = move_and_slide(motion, UP)
	pass


extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80	
const FRICTION = 500

var velocity = Vector2.ZERO

onready var merlin = $AnimatedSprite

func _physics_process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()
	
	if input != Vector2.ZERO:
		if input.x == 1:
			merlin.play("walk")
			merlin.flip_h = false
		elif input.x == -1:
			merlin.play("walk")
			merlin.flip_h = true
		
		
		velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)
	else:
		merlin.play("stand")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_collide(velocity * delta)

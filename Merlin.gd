extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80	
const FRICTION = 500

var velocity = Vector2.ZERO

onready var merlin = $AnimatedSprite

func _physics_process(delta):
	var input = get_movement_input(delta)
	handle_movement(input, delta)

func get_movement_input(delta):
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input = input.normalized()

	return input

func handle_movement(input, delta):
	if input != Vector2.ZERO:
		handle_walk_direction(input)
		handle_positive_walk_velocity(input, delta)
	else:
		idle()
		handle_negative_walk_velocity(input, delta)

	move_and_collide(velocity * delta)

func handle_walk_direction(input):
	if is_walking_right(input):
		walk_right()
	elif is_walking_left(input):
		walk_left()
	
	if is_walking_up(input):
		walk_up()
	elif is_walking_down(input):
		walk_down()

func handle_positive_walk_velocity(input, delta):
	velocity = velocity.move_toward(input * MAX_SPEED, ACCELERATION * delta)

func handle_negative_walk_velocity(input, delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
func is_walking_right(input):
	return input.x == 1

func is_walking_left(input):
	return input.x == -1

func is_walking_up(input):
	return input.y == -1

func is_walking_down(input):
	return input.y == 1

func walk_right():
	merlin.play("walk")
	merlin.flip_h = false

func walk_left():
	merlin.play("walk")
	merlin.flip_h = true

func walk_up():
	merlin.play("vert_walk_up")
	merlin.flip_v = false

func walk_down():
	merlin.play("vert_walk")
	merlin.flip_v = false
func idle():
	merlin.play("stand")

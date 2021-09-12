extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80	
const FRICTION = 500

var velocity = Vector2.ZERO

onready var merlin = $AnimationPlayer
onready var merlinAnimationTree = $AnimationTree
onready var merlinAnlimationState = merlinAnimationTree.get("parameters/playback")

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
	update_blend_position(input)
	
	if input != Vector2.ZERO:
		run()
		handle_positive_walk_velocity(input, delta)
	else:
		idle()
		handle_negative_walk_velocity(input, delta)

	move_and_collide(velocity * delta)

func update_blend_position(input):
	merlinAnimationTree.set("parameters/idle/blend_position", input)
	merlinAnimationTree.set("parameters/run/blend_position", input)	
	

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

func run():
	merlinAnlimationState.travel("run")
	
func idle():
	merlinAnlimationState.travel("idle")

extends Area2D

export var speed = 400
var screen_size
var acceleration = .25

func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += acceleration
	if Input.is_action_pressed("ui_left"):
		velocity.x -= acceleration
	if Input.is_action_pressed("ui_down"):
		velocity.y += acceleration
	if Input.is_action_pressed("ui_up"):
		velocity.y -= acceleration
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

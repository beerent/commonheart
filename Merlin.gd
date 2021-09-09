extends Area2D

export var speed = 400
var acceleration = .25

func _ready():
	pass

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
	
	position += velocity * delta

	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		#$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "vert_walk"
		#$AnimatedSprite.flip_v = velocity.y > 0
	else:
		#$AnimatedSprite.flip_v = false
		$AnimatedSprite.animation = "stand"
		



func _on_Area2D_area_entered(area):
	speed = 200


func _on_Merlin_area_exited(area):
	speed = 400

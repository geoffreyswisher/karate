extends KinematicBody2D

var speed = 200
var jumpspeed = -500
var gravity = 1200

var velocity = Vector2()

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	if Input.is_action_pressed("ui_left"):
		velocity.x += -speed
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		velocity.y += jumpspeed
	

func _physics_process(delta):
	print(delta)
	velocity.y += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2(0,-1))



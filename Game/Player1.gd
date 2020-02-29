extends KinematicBody2D

var speed = 300
var jumpspeed = -800
var gravity = 1500

var velocity = Vector2()

var Health = load("res://Game/Health.gd")
var health = Health.new()

var hitmarker = preload("res://Game/HitMarker.tscn")

func _ready():
	print(health.player_health)

func get_input():

	velocity.x = 0

	if Input.is_action_pressed("ui_right"):
		velocity.x += speed

	if Input.is_action_pressed("ui_left"):
		velocity.x += -speed

	if is_on_floor() and Input.is_action_pressed("ui_up"):
		velocity.y += jumpspeed

	if Input.is_action_just_pressed("game_x"):
		if check_in_range():
			if subtract_enemy_health(5) > 0:
				display_hit_marker()
		print('kick')

	if Input.is_action_just_pressed("game_z"):
		if check_in_range():
			if subtract_enemy_health(5) > 0:
				display_hit_marker()
		print('punch')


func _physics_process(delta):
	
	get_input()
	
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0,-1))


func get_enemy_position():
	var enemy = self.owner.get_child(2)
	if enemy:
		var enemy_pos = enemy.position
		return enemy_pos
	else:
		return Vector2(0,0)


func check_in_range():
	var enemy_pos = get_enemy_position()
	var self_pos = self.position
	
	if (abs(self_pos.x - enemy_pos.x) <= 90):
		print("hit")
		return true
	
	else:
		return false


func subtract_enemy_health(factor):
	health.enemy_health -= factor
	print(health.enemy_health)
	
	if health.enemy_health <= 0:
		var enemy = self.owner.get_child(2)
		self.owner.remove_child(enemy)
	return health.enemy_health


func display_hit_marker():
	var enemy = self.owner.get_child(2)
	var instance = hitmarker.instance()
	enemy.add_child(instance)
	

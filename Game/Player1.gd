# wait until animation is finished:  https://godotengine.org/qa/12131/wait-until-animation-is-finished


extends KinematicBody2D


var speed = 300
var jumpspeed = -800
var gravity = 1500
var velocity = Vector2()

var Health = load("res://Game/Health.gd")
var health = Health.new()
var max_health = health.player_health

var hitmarker = preload("res://Game/HitMarker.tscn")

var p = "Player"

var facing_right = true
onready var animation = $Animations

func _ready():
	pass

func get_input():
	velocity.x = 0

	if Input.is_action_pressed("ui_right"):
		animation.flip_h = false
		facing_right = true
		animation.play("Walk")
		
		
		velocity.x += speed

	if Input.is_action_pressed("ui_left"):
		animation.flip_h = true
		facing_right = false
		animation.play("Walk")
		velocity.x += -speed

	if is_on_floor() and Input.is_action_pressed("ui_up"):
		velocity.y += jumpspeed

	if Input.is_action_just_pressed("game_x"):
		
		animation.play("Kick")
		
		for enemy in owner.get_node("Enemies").get_children():
			if check_in_range(enemy):
				if subtract_enemy_health(enemy, 5) > 0:
					hit(enemy)

	if Input.is_action_just_pressed("game_z"):
		
		animation.play("Punch")
		
		
		for enemy in owner.get_node("Enemies").get_children():
			if check_in_range(enemy):
				if subtract_enemy_health(enemy, 5) > 0:
					hit(enemy)


func yield_to_animation():
	yield(animation, "animation_finished")


func get_enemy_position(node):
	var enemy = node
	if enemy:
		var enemy_pos = enemy.position
		return enemy_pos
	else:
		return Vector2(0,0)


func check_in_range(node):
	var enemy_pos = get_enemy_position(node)
	var self_pos = self.position
	
	if (abs(self_pos.x - enemy_pos.x) <= 150) and (abs(self_pos.y - enemy_pos.y) <= 100):
		if facing_right and (self_pos.x - enemy_pos.x) < 0:
			return true
		if !facing_right and (enemy_pos.x - self_pos.x) < 0:
			return true
	
	else:
		return false


func subtract_enemy_health(node, factor):
	var enemy_health = node.subtract_own_health(factor)
	if enemy_health <= 0:
		self.owner.get_node("Enemies").remove_child(node)
	
	return enemy_health


func subtract_player_health(factor):
	health.player_health -= factor
	var healthbar = $Node2D
	healthbar.update_healthbar(health.player_health)
	if health.player_health <= 0:
		get_tree().change_scene("res://Game/Game_Over.tscn")


func display_hit_marker(node):
	var enemy = owner.get_node(node)
	var instance = hitmarker.instance()
	enemy.add_child(instance)
	
func hit(node):
	var instance = hitmarker.instance()
	node.add_child(instance)

func check_position():
	if position.y > 2000:
		get_tree().change_scene("res://Game/Game_Over.tscn")


func _physics_process(delta):
	
	get_input()
	check_position()
	#yield_to_animation()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0,-1))

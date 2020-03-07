extends KinematicBody2D

var velocity = Vector2()
var speed = 150
var gravity = 1500
var jumpspeed = -800
var delay = 100
var player_positions = []
var hit_delay = 60  # replace with wait for animation

var p = "Player"
var e = "../Enemy"

var Health = load("res://Game/Health.gd")
var health = Health.new()
var max_health = health.enemy_health

onready var animation = $Animations

func _ready():
	health.initialize(get_tree().get_current_scene().get_name())
	print(health.enemy_health)


# movement of the enemy to the player with a semi-fluid delay
func movement(player_pos):
	
	# stabilize movement
	velocity.x = 0
	
	# create a stack of player positions where 0 is the oldest
	# and delay-1 is the youngest
	for i in range(delay):
		if len(player_positions) < delay:
			player_positions.append(player_pos)
			break
		elif i > 0:
			player_positions[i-1] = player_positions[i]
			if i == delay - 1:
				player_positions[delay-1] = player_pos
	
	
	# determine average position from [delay] player positions
	var sum = Vector2(0,0)
	for pos in player_positions:
		sum += pos
	var avg = Vector2(sum.x/len(player_positions), sum.y/len(player_positions))
	
	
	# determine x direction from average position 
	var xdisplacement = avg.x - position.x
	var ydisplacement = avg.y - position.y
	var xdirection = int(xdisplacement / abs(xdisplacement))

	if abs(xdisplacement) < 500 and abs(ydisplacement) < 300: 
		velocity.x = speed * xdirection
		
		if avg.y < self.position.y:
			jump()
	
	
	


func get_player_collisions():
	for slide in get_slide_count():
		var collision = get_slide_collision(slide)
		
		if collision.collider.name == "Player":
			if hit_delay == 60:
				owner.get_node(p).subtract_player_health(5)
				owner.get_node(p).display_hit_marker(p)
				hit_delay = 0
				
			else:
				hit_delay += 1
				
			return true

	return false


func jump():
	#velocity.y = 0
	if is_on_floor():
		velocity.y += jumpspeed


func subtract_own_health(factor):
	health.enemy_health -= factor
	var healthbar = $Health
	healthbar.update_healthbar(health.enemy_health)
	return health.enemy_health


func animations():
	if velocity.x > 0:
		animation.flip_h = false
		animation.play("Walk")
	if velocity.x < 0:
		animation.flip_h = true
		animation.play("Walk")

func check_position():
	if position.y > 2000:
		self.get_parent().remove_child(self)

func _physics_process(delta):
	var player_pos = owner.get_node(p).position
	movement(player_pos)
	
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2(0,-1))
	get_player_collisions()
	animations()
	
	check_position()

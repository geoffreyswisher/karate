extends KinematicBody2D

var velocity = Vector2()
var speed = 150
var gravity = 1500
var jumpspeed = -800
var delay = 100
var player_positions = []
var hit_delay = 50  # replace with wait for animation

var p = "../Player"
var e = "../Enemy"

func _ready():
	pass 


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
	var xdirection = int(xdisplacement / abs(xdisplacement))

	
	velocity.x = speed * xdirection


func get_player_collisions():
	for slide in get_slide_count():
		var collision = get_slide_collision(slide)
		
		if collision.collider.name == "Player":
			if hit_delay == 50:
				get_node(p).subtract_player_health(10)
				get_node(p).display_hit_marker(p)
				hit_delay = 0
				
				
			else:
				hit_delay += 1
				
			return true
		else:
			jump()
	return false


func jump():
	velocity.y = 0
	if is_on_floor():
		
		velocity.y = jumpspeed


func _physics_process(delta):
	var player_pos = get_node(p).position
	movement(player_pos)
	
	
	move_and_slide(velocity, Vector2(0,-1))
	
	if !(get_player_collisions()):
		velocity.y += gravity * delta
		print(velocity.y)

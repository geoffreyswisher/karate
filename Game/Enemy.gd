extends KinematicBody2D

var velocity = Vector2()
var speed = 150
var delay = 100
var player_positions = []

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

func _process(delta):
	var player_pos = self.owner.get_child(1).position
	movement(player_pos)
	
	move_and_slide(velocity, Vector2(0,-1))

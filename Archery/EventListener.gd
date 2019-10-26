extends Node

var targetpos = Vector2(0,0)

func _ready():
	targetpos = get_node("../Target").get_position()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

#--------------------------------------------------------------------------------

var gamescore = 0

var arrowcounter = 0

const Arrow = preload("res://Archery/Items/Arrow.tscn")

func _input(event):
	
	if event is InputEventMouseButton && event.is_pressed():
		
		var ArrowInstance = Arrow.instance()
		ArrowInstance.name = 'Arrow' + str(arrowcounter)
		
		get_node("../Arrows").add_child(ArrowInstance)
		var pos = get_node('../Cursor').posofarrow(event.position)
		get_node('../Arrows/Arrow' + str(arrowcounter)).set_position(pos)
		
		checkposition(pos)
		
		arrowcounter += 1

func checkposition(position):
	
	var distanceToTarget = position.distance_to(targetpos)
	print(distanceToTarget)
	
	if distanceToTarget <= 16:
		print('Bullseye')
		gamescore += 10
	elif distanceToTarget <= 27:
		gamescore += 8
	elif distanceToTarget <= 44:
		gamescore += 6
	elif distanceToTarget <= 60:
		gamescore += 4
	elif distanceToTarget <= 75:
		gamescore += 3
	elif distanceToTarget <= 92.5:
		gamescore += 2
	elif distanceToTarget <= 107:
		gamescore += 1

	get_node('../Score').text = "Score: " + str(gamescore)
	

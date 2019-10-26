extends Sprite

var pos = Vector2()
var sway = Vector2() # the sway for 
var velocity = Vector2() # a vector 2 for the sway function
var iterator = float(0) # an iterator for the trig functions in the sway function

func _process(delta):
	sway()
	position = pos + sway

func _input(event):
	if event is InputEventMouseMotion:
		pos = event.position

func sway():
	#velocity.x = sin(iterator) * 50
	velocity.x = 30 * iterator
	velocity.y = cos(iterator) * 30
	sway = velocity
	print(sway)
	
	iterator += 0.02

func posofarrow(eventpos):
	return eventpos + sway
extends Node2D

var scene_order = ['Grass_Level', 'Stone_Level',  'Dojo_Level']
var current_scene = ""

func _ready():
	current_scene = get_tree().get_current_scene().get_name()

var secdelay = 0


func get_player_pos():
	return self.owner.get_node("Player").position


func get_input():
	if Input.is_action_pressed("ui_accept"):
		if  secdelay >= 60:
			if abs(get_player_pos().x - self.position.x) <= 200:
				if !self.owner.get_node("Enemies").get_children() and determine_next_level(current_scene):
					navigate_to_scene(determine_next_level(current_scene))


func determine_next_level(cs):
	if scene_order.find(cs) != len(scene_order) - 1:
		return scene_order[scene_order.find(cs)+1]
	elif scene_order.find(cs) == len(scene_order) -1:
		print(cs)
		get_tree().change_scene("res://Game/You_Win/You_Win.tscn")
		return null
	else:
		return null

func navigate_to_scene(scene):
	var folder = ""
	for i in range(len(scene)):
		if scene[i] == "_":
			folder = scene.substr(0,i)
	var path = "res://Game/" + folder + "/" + scene + ".tscn"
	print(get_tree().change_scene(path))
	

func _process(delta):
	if secdelay < 60:
		secdelay += 1
	get_input()

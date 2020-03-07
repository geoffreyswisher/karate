extends Control

var file = File.new()
var previous_level = ""
	

func _ready():
	file.open("res://Game/previous_level.txt", File.READ)
	var data = {}
	previous_level = file.get_line()


func _on_retry_button_pressed():
	get_tree().change_scene(previous_level)

func _on_quit_button_pressed():
	get_tree().quit()

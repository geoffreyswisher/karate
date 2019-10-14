extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#iterate through all buttons
	for button in $Menu/CenterRow/Buttons.get_children():

		#connect each button
		#when button is pressed, call on_Button_pressed function with param scene_to_load 
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])


func _on_Button_pressed(scene_to_load):

	#for the packed scene export, we need to use a function that has packed scene parameter
	get_tree().change_scene_to(scene_to_load)


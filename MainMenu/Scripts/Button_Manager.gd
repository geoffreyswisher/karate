extends Control

func _ready():
	
	for button in $Menu/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load]) 

func _on_Button_pressed(scene_to_load):
	get_tree().change_scene_to(scene_to_load)



func _on_BackButton_pressed():
	get_tree().change_scene("res://MainMenu/TitleScreen/TitleScreen.tscn")


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Game/MainScene.tscn")


func _on_ContinueButton_pressed():
	get_tree().change_scene("res://Game/MainScene.tscn")

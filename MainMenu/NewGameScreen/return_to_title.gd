#used for all back buttons returning to the title scree

extends Control

func _on_BackButton_pressed():
	get_tree().change_scene("res://MainMenu/TitleScreen/TitleScreen.tscn")


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Archery/Game.tscn")

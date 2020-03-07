extends Node2D

var dir = Directory.new()
var file = File.new()

func _ready():
	dir.remove("res://Game/previous_level.txt")
	file.open("res://Game/previous_level.txt", File.WRITE)
	file.store_line("res://Game/Stone/Stone_Level.tscn")


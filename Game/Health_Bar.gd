extends Node2D


var green_bar = preload("res://Assets/Health_Bar/full_health.png")

onready var healthbar = $HealthBar

func _ready():
	healthbar.max_value = get_parent().max_health
	healthbar.value = get_parent().max_health


func update_healthbar(value):
	healthbar.texture_progress = green_bar
	healthbar.value = value


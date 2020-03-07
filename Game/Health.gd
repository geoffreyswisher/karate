var player_health = 50
var enemy_health = 30

func initialize(scene):
	var current_scene = scene
	if current_scene == "Grass_Level":
		enemy_health = 20
	if current_scene == "Stone_Level":
		enemy_health = 30
	if current_scene == "Dojo_Level":
		enemy_health = 50

func getPlayerHealth():
	return player_health

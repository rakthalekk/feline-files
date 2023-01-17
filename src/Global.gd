extends Node
var uvmode = false
var pawprintdetect = 0
var uvtimer = 100

var map = 1

func _process(_delta):
	if (uvmode and uvtimer > 0):
		uvtimer -= 1
	else:
		uvmode = false
		if (uvtimer < 100):
			uvtimer += 0.5


func to_next_map():
	map += 1
	get_tree().change_scene("res://src/Map" + str(map) + ".tscn")

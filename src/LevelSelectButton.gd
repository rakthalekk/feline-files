extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _pressed():
	var map = get_parent().get_node("MapOption").selected;
	if map == 0:
		get_tree().change_scene("res://src/Map1.tscn")
	elif map == 1:
		get_tree().change_scene("res://src/Map2.tscn")
	elif map == 2:
		get_tree().change_scene("res://src/Map3.tscn")

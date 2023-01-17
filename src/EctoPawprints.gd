class_name EctoPawprints
extends Area2D

var instance = 0


func _process(_delta):
	_visible()
	
func _visible():
	if (instance == 1 and Global.uvmode):
		self.visible = true
	else:
		self.visible = false

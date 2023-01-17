extends CanvasLayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_parent().get_parent().get_node("TitleScreen").visible = true
	get_parent().get_parent().get_node("StartButton").visible = true
	get_parent().get_parent().get_node("HowToPlayButton").visible = true
	get_parent().get_parent().get_node("NotebookButton").visible = true
	get_parent().get_parent().get_node("GuideButton").visible = true
	get_parent().get_node("HowToPlay").visible = false

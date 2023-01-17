extends CanvasLayer

func _on_StartButton_pressed():
	get_tree().change_scene("res://src/Level Select.tscn")

func _on_HowToPlayButton_pressed():
	get_node("TitleScreen").visible = false
	get_node("StartButton").visible = false
	get_node("HowToPlayButton").visible = false
	get_node("NotebookButton").visible = false
	get_node("GuideButton").visible = false
	get_node("HowToPlayButton/HowToPlay").visible = true

func _on_NotebookButton_pressed():
	if $Journal.visible == false:
		$Journal.visible = true
	else:
		$Journal.visible = false
	
func _on_GuideButton_pressed():
	get_tree().change_scene("res://src/Guide.tscn")

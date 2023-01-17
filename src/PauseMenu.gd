extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.visible:
		get_tree().paused = true;
	if Input.is_action_just_pressed("pause"):
		if get_parent().get_node("Journal").visible:
			get_parent().get_node("Journal").visible = false;
			get_tree().paused = false;
		elif get_parent().get_node("PauseMenu").visible:
			get_parent().get_node("PauseMenu").visible = false;
			get_tree().paused = false;
		else:
			get_parent().get_node("PauseMenu").visible = true;

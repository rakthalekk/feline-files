extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var labels
var ghost_detector_text

# Called when the node enters the scene tree for the first time.
func _ready():
	labels = get_node("/root/Notebook/Labels")
	ghost_detector_text = get_node("/root/Notebook/Labels/GhostDetectorDesc")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _pressed():
	for i in labels.get_children():
		i.visible = false;
	ghost_detector_text.visible = true;

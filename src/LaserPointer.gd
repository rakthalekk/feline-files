extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var labels
var pointer_text

# Called when the node enters the scene tree for the first time.
func _ready():
	labels = get_node("/root/Notebook/Labels")
	pointer_text = get_node("/root/Notebook/Labels/LaserPointerDesc")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _pressed():
	for i in labels.get_children():
		i.visible = false;
	pointer_text.visible = true;

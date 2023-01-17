extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const images = [preload("res://assets/scratch marks/Scratch Marks-Large.png"),preload("res://assets/scratch marks/Scratch Marks-Medium.png"),preload("res://assets/scratch marks/Scratch Marks-Small.png")]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	texture = images[randi() % images.size()];


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

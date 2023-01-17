extends ObjectInteractable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var bready = preload("res://assets/sprites/Toaster w Bread.png");

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact(interactor):
	get_node("Sprite").texture = bready;
	get_node("Toaster").play();
	.interact(interactor);

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

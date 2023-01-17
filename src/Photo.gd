extends ObjectInteractable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var broken = preload("res://assets/sprites/Framed Pic Broken.png");

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact(interactor):
	get_node("AudioStreamPlayer2D").play();
	velocity = interactor.get_throw_strength() * (position - interactor.position).normalized() * 100;
	get_node("Sprite").texture = broken;
	get_node("AudioStreamPlayer2D2").play();

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


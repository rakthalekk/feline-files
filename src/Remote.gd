extends ObjectInteractable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact(interactor):
	get_node("AudioStreamPlayer2D").play();
	velocity = interactor.get_throw_strength() * (position - interactor.position).normalized() * 100;
	var tv = get_parent().get_node("Television");
	if tv != null:
		tv.toggle();

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

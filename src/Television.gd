extends ObjectInteractable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact(interactor):
	toggle();

func toggle():
	get_node("AnimatedSprite").visible = !get_node("AnimatedSprite").visible;
	if get_node("StaticNoise").is_playing():
		get_node("StaticNoise").stop();
	else:
		get_node("StaticNoise").play();

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

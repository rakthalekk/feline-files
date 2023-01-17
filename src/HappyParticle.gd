extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO;
export var speed = 200;
export var lifespan = 1000;
onready var start_time = OS.get_ticks_msec();
# Called when the node enters the scene tree for the first time.
func _ready():
	var angle = randf() * 2 * PI;
	velocity = sin(angle) * Vector2.UP + cos(angle) * Vector2.RIGHT;
	pass # Replace with function body.

var permanent = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if permanent:
		return;
	position += velocity;
	if OS.get_ticks_msec() > start_time + lifespan:
		get_parent().remove_child(self);

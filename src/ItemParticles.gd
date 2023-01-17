extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var particle_count = 10;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shoot_particles():
	for i in particle_count:
		var new_particle = get_node("AnimatedSprite").duplicate();
		new_particle.permanent = false;
		new_particle.visible = true;
		get_parent().get_parent().add_child(new_particle);
		new_particle.position = get_parent().position;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

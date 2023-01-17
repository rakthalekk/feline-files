extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var room_name = "base_room"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("RoomManager").add_room(self);


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_x():
	return position.x + get_node("CollisionShape2D").position.x;
	pass;
	
func get_y():
	return position.y + get_node("CollisionShape2D").position.y;
	pass;

func get_w():
	return get_node("CollisionShape2D").get_shape().extents.x * scale.x;
	pass;

func get_h():
	return get_node("CollisionShape2D").get_shape().extents.y * scale.y;
	pass;

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

onready var object_manager = get_parent().get_node("ObjectManager");

func get_random_room():
	if rooms.size() == 0:
		return null;
	return rooms[randi() % rooms.size()];

func get_room_by_type(type):
	var arr = [];
	for room in rooms:
		if room.room_name == type:
			arr.push(room);
	return arr[randi() % arr.size()];

var rooms = [];
var area_per_furniture = 4000;

func add_room(obj):
	rooms.push_back(obj);
	var area = obj.get_w() * obj.get_h();
	var max_furniture = area/area_per_furniture;
	var furniture_count = rand_range(0, max_furniture);
	for i in furniture_count:
		object_manager.spawn_object(obj);

func get_room_at_position(pos):
	for room in rooms:
		var w = room.get_w()
		var h = room.get_h()
		if pos.x >= room.get_x() - w  && pos.x <= room.get_x() + h && pos.y >= room.get_y() - h && pos.y <= room.get_y() + h:
			return room
	return null

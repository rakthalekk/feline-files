extends Node2D


var potential_objects_location = [];
var potential_objects_rooms = [];
var potential_objects = [];
var potential_objects_names = [];
var objects = [];

func load_object(location, rooms, name = ""):
	potential_objects_location.push_back(location);
	potential_objects_rooms.push_back(rooms);
	potential_objects.push_back(load(location));
	potential_objects_names.push_back(name);

# Called when the node enters the scene tree for the first time.
func _ready():
	#Here you can put all objects in the game
	load_object("res://src/PoolBall.tscn", ["recreation_room"], "pool_ball");
	load_object("res://src/CueBall.tscn", ["recreation_room"], "pool_ball");
	load_object("res://src/8Ball.tscn", ["recreation_room"], "pool_ball");
	#load_object("res://src/Remote.tscn", ["recreation_room","living_room"], "remote");
	load_object("res://src/ScratchPost.tscn", ["recreation_room","living_room","bedroom"], "scratch_post");
	#load_object("res://src/Photo.tscn", ["recreation_room","living_room","bedroom"], "photo");
	#load_object("res://src/Photo1.tscn", ["recreation_room","living_room","bedroom"], "photo");
	#load_object("res://src/Photo2.tscn", ["recreation_room","living_room","bedroom"], "photo");
	load_object("res://src/Brush.tscn", ["bathroom"], "brush");
	#load_object("res://src/CoffeeTable.tscn", ["living_room","dining_room"]);
	#load_object("res://src/SideTable.tscn", ["living_room","recreation_room","bedroom"]);
	load_object("res://src/Catbed.tscn", ["living_room","bedroom"], "catbed");
	load_object("res://src/Yarn.tscn", ["living_room","bedroom"], "yarn");
	load_object("res://src/Collar.tscn", ["living_room","bedroom"], "collar");
	load_object("res://src/Toaster.tscn", ["kitchen"]);
	load_object("res://src/Burger.tscn", ["kitchen","dining_room"], "burger");
	load_object("res://src/Steak.tscn", ["kitchen","dining_room"], "steak");
	load_object("res://src/Fish.tscn", ["kitchen","dining_room"], "fish");
	load_object("res://src/Cup.tscn", ["kitchen","dining_room","living_room","recreation_room"], "cup");
	load_object("res://src/Mouse.tscn", ["bathroom","kitchen","closet","garage","pantry"], "mouse");
	load_object("res://src/Broom.tscn", ["kitchen","closet","garage","pantry"], "broom");
	load_object("res://src/Sock.tscn", ["bedroom","closet","living_room","closet"], "sock");
	load_object("res://src/Barstool.tscn", ["kitchen", "dining_room","recreation_room"], "barstool");

func get_object(room):
	var results = [];
	for i in potential_objects_rooms.size():
		for j in potential_objects_rooms[i].size():
			if(potential_objects_rooms[i][j] == room):
				results.push_back(i);
	if results.size() == 0:
		return -1;
	return results[randi() % results.size()];

func spawn_object(room):
	var room_type = room.room_name;
	var index = get_object(room_type);
	if index == -1:
		return;
	var new_obj = potential_objects[index].instance();
	get_parent().call_deferred("add_child",new_obj);
	new_obj.position = Vector2.RIGHT * rand_range(room.get_x() - room.get_w()/2, room.get_x() + room.get_w()/2) - Vector2.UP * rand_range(room.get_y() - room.get_h()/2, room.get_y() + room.get_h()/2);

func contains(obj):
	for object in objects:
		if object.object_name == obj:
			return true;
	return false;

func spawn_specific_object(obj_name):
	print("attempt " + obj_name);
	var new_obj = null;
	for i in potential_objects.size():
		#print("this is a " + potential_objects_names[i])
		if potential_objects_names[i] == obj_name:
			new_obj = potential_objects[i];
	if new_obj == null:
		return;
	# print("got " + obj_name);
	var new_obj_2 = new_obj.instance();
	var room = get_parent().get_node("RoomManager").get_random_room();
	get_parent().call_deferred("add_child",new_obj_2);
	new_obj_2.position = Vector2.RIGHT * rand_range(room.get_x() - room.get_w()/2, room.get_x() + room.get_w()/2) - Vector2.UP * rand_range(room.get_y() - room.get_h()/2, room.get_y() + room.get_h()/2);

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	pass

func get_objects_near(position, interaction_range):
	var return_value = [];
	for i in objects.size():
		if position.distance_to(objects[i].position) < interaction_range:
			return_value.push_back(objects[i]);
	return return_value;

func add_object(new_object):
	objects.push_back(new_object);

extends Node2D

onready var camera_icon = preload("res://assets/icons/Icons-Camera.png");
onready var laser_icon = preload("res://assets/icons/Icons-Laser.png");
onready var detector_icon = preload("res://assets/icons/Icons-Detector.png");
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var start_time = 0;
var ms_per_minute = 1000;

func get_current_time():
	var hour = 8;
	var minute = 0;
	var delta = (OS.get_ticks_msec() - start_time)/ ms_per_minute;
	hour += int(delta / 60);
	minute = int(int(delta) % 60);
	var minute2;
	if minute < 10:
		minute2 = "0" + str(minute);
	else:
		minute2 = str(minute);
	if hour >= 13:
		hour -= 12;
	var labeltext = str(hour) + ":" + minute2;
	if hour < 8:
		labeltext += "AM"
	else:
		labeltext += "PM"
	get_node("Label").text = labeltext;
	if hour == 6:
		get_tree().change_scene("res://src/LoseScreen.tscn")
		
func speed_up():
	ms_per_minute *= 0.8;

func _ready():
	start_time = OS.get_ticks_msec();
	$ItemList.add_item("Camera", camera_icon);
	$ItemList.add_item("Laser Pointer", laser_icon);
	$ItemList.add_item("Detector", detector_icon);

var items = [];

func remove_item(index):
	items.remove(index);
	$ItemList.remove_item(index + 3);
	$ItemList.select(0);

func _process(_delta):	
	get_current_time();
	$ProgressBar.value = Global.uvtimer
	var player = get_parent();
	if player.current_tool == "camera":
		$ItemList.select(0);
	elif player.current_tool == "laser_pointer":
		$ItemList.select(1);
	elif player.current_tool == "ghost_detector":
		$ItemList.select(2);
	elif player.current_tool == "1":
		$ItemList.select(3);
	elif player.current_tool == "2":
		$ItemList.select(4);
	elif player.current_tool == "3":
		$ItemList.select(5);
		
	for i in player.items.size():
		if !items.has(player.items[i]):
			items.push_back(player.items[i]);
			$ItemList.add_item(items[i].object_name, items[i].get_node("Sprite").texture);


func scene_transition():
	if Global.map < 3:
		Global.to_next_map()
	else:
		get_tree().change_scene("res://src/WinScreen.tscn")


func play_transition_screen(name):
	if name == "ghost_house_cat":
		$Sprite.texture = load("res://assets/journal/Polaroids-Ghost Cat.png")
	elif name == "zombie_tiger":
		$Sprite.texture = load("res://assets/journal/Polaroids-Zombie Tiger.png")
	elif name == "lich_lynx":
		$Sprite.texture = load("res://assets/journal/Polaroids-Lich Leopard.png")
	else:
		$Sprite.texture = load("res://assets/journal/Polaroids-Witch Cat.png")
	$AnimationPlayer.play("transition")


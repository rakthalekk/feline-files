class_name Cat
extends KinematicBody2D



export var speed = 100;


var photographed = false

var progress = [false, false, false];
onready var happy_cat = get_node("HappySound");
onready var angry_cat = get_node("AngrySound");

func add_progress(index):
	print("progress")
	progress[index] = true;
	if progress[0] and progress[1] and progress[2]:
		get_node("Sprite").visible = true;
	happy_cat.play();
	get_node("ItemParticles").shoot_particles();

func impact_with_object(obj):
	obj.get_parent().remove_child(obj);
	if obj.object_name == "steak" && get_name() == "zombie_tiger":
		add_progress(0);
	elif obj.object_name == "fish" && get_name() == "lich_lynx":
		add_progress(0);
	elif obj.object_name == "broom" && get_name() == "witch_cat":
		add_progress(0);
	elif obj.object_name == "mouse" && get_name() == "ghost_house_cat":
		add_progress(0);
	
	if obj.object_name == "sock" && get_evidence_types()[0] == "paw":
		add_progress(1);
	elif obj.object_name == "catbed" && get_evidence_types()[0] == "breath":
		add_progress(1);
	elif obj.object_name == "collar" && get_evidence_types()[0] == "meow":
		add_progress(1);
	elif obj.object_name == "yarn" && get_evidence_types()[0] == "scratch":
		add_progress(1);
	elif obj.object_name == "brush" && get_evidence_types()[0] == "orb":
		add_progress(1);
		
	if obj.object_name == "sock" && get_evidence_types()[1] == "paw":
		add_progress(2);
	elif obj.object_name == "catbed" && get_evidence_types()[1] == "breath":
		add_progress(2);
	elif obj.object_name == "collar" && get_evidence_types()[1] == "meow":
		add_progress(2);
	elif obj.object_name == "yarn" && get_evidence_types()[1] == "scratch":
		add_progress(2);
	elif obj.object_name == "brush" && get_evidence_types()[1] == "orb":
		add_progress(2);
	
	if !happy_cat.is_playing():
		angry_cat.play();
		get_parent().get_node("Player").get_node("UI").speed_up();

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();
	get_new_room();
	get_new_target();
	generate_cat();
	play_running_animation()

var cat_types = 4

var orb = preload("res://src/GhostOrb.tscn")


func play_running_animation():
	if get_name() == "ghost_house_cat":
		$AnimationPlayer.play("house_cat_walk")
	elif get_name() == "zombie_tiger":
		$AnimationPlayer.play("tiger_walk")
	elif get_name() == "lich_lynx":
		$AnimationPlayer.play("leopard_walk")
	else:
		$AnimationPlayer.play("witch_walk")


func generate_cat():
	var cat_index = randi() % cat_types;
	stats.generate(cat_index);
	if get_evidence_types().has("orb"):
		add_child(orb.instance());

var verified_winnable = false;

func verify_winnable(evidence):
	var result = true;
	if evidence == "zombie_tiger":
		if !get_parent().get_node("ObjectManager").contains("steak"):
			get_parent().get_node("ObjectManager").spawn_specific_object("steak");
			result = false;
	if evidence == "lich_lynx":
		if !get_parent().get_node("ObjectManager").contains("fish"):
			get_parent().get_node("ObjectManager").spawn_specific_object("fish");
			result = false;
	if evidence == "ghost_house_cat":
		if !get_parent().get_node("ObjectManager").contains("mouse"):
			get_parent().get_node("ObjectManager").spawn_specific_object("mouse");
			result = false;
	if evidence == "witch_cat":
		if !get_parent().get_node("ObjectManager").contains("broom"):
			get_parent().get_node("ObjectManager").spawn_specific_object("broom");
			result = false;
	if evidence == "orb":
		if !get_parent().get_node("ObjectManager").contains("brush"):
			get_parent().get_node("ObjectManager").spawn_specific_object("brush");
			result = false;
	if evidence == "paw":
		if !get_parent().get_node("ObjectManager").contains("sock"):
			get_parent().get_node("ObjectManager").spawn_specific_object("sock");
			result = false;
	if evidence == "meow":
		if !get_parent().get_node("ObjectManager").contains("collar"):
			get_parent().get_node("ObjectManager").spawn_specific_object("collar");
			result = false;
	if evidence == "breath":
		if !get_parent().get_node("ObjectManager").contains("catbed"):
			get_parent().get_node("ObjectManager").spawn_specific_object("catbed");
			result = false;
	if evidence == "scratch":
		if !get_parent().get_node("ObjectManager").contains("yarn"):
			get_parent().get_node("ObjectManager").spawn_specific_object("yarn");
			result = false;
	return result;

func verify_all_winnable():
	return verify_winnable(get_name()) and verify_winnable(get_evidence_types()[0]) and verify_winnable(get_evidence_types()[1]);

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	if photographed:
		$Sprite.visible = true
		return
	if progress[0] && progress[1] && progress[2]:
		$Sprite.visible = true
	
	move_towards_target();
	attempt_interact();
	attempt_leave_evidence();
	if !verified_winnable:
		verified_winnable = verify_all_winnable();
		if verified_winnable:
			print("confirmed winnable");
	


var target = Vector2.ZERO;
onready var room_manager = get_parent().get_node("RoomManager");
var current_room = null;

var base_change_room_probability = 0.02;

func get_new_room():
	current_room = room_manager.get_random_room();
	if current_room != null:
		if(current_room.room_name == "bedroom" && get_name() == "lich_lynx"):
			get_new_room();
		print("I'm going to the " + current_room.room_name)

func get_new_target():
	if randf() < base_change_room_probability * get_mobility():
		get_new_room();
	if current_room == null:
		return;
	
	var laser_beam= get_parent().get_node("Player").get_node("Beam");
	if laser_beam.is_casting:
		var beam_pos = laser_beam.laser_position;
		print(beam_pos);
		if randf() < (1 - get_spite()):
			target = beam_pos;
			return;
	target = Vector2.RIGHT * rand_range(current_room.get_x() - current_room.get_w()/2, current_room.get_x() + current_room.get_w()/2) - Vector2.UP * rand_range(current_room.get_y() - current_room.get_h()/2, current_room.get_y() + current_room.get_h()/2);
	

var pathfind_distance = 1;

func move_towards_target():
	var direction = (target - position).normalized()
	if direction.x > 0:
		$Sprite.scale.x = 2
	else:
		$Sprite.scale.x = -2
	move_and_slide(direction * speed);
	if position.distance_to(target) <= pathfind_distance:
		get_new_target();
	

var last_interaction_time = 0;

func attempt_interact():
	if OS.get_ticks_msec() < last_interaction_time + get_interaction_cooldown():
		return;
	var object_manager = get_parent().get_node("ObjectManager");
	var nearby_objects = object_manager.get_objects_near(position, get_interaction_range());
	if nearby_objects.size() > 0:
		var obj = nearby_objects[rand_range(0, nearby_objects.size())];
		if randf() < get_object_affinity(obj) * get_interaction_probability():
			obj.interact(self);
	last_interaction_time = OS.get_ticks_msec();

var last_evidence_time = 0;

onready var meow_sound = get_node("AudioStreamPlayer2D");
onready var pawprint = preload("res://src/EctoPawprints.tscn");
onready var scratch = preload("res://src/ScratchMarks.tscn");

func attempt_leave_evidence():
	# Spawn evidence nearby such as ecto pawprints or something
	# Get potential types of evidence for the ghost
	# Check probability
	# Spawn evidence
	if OS.get_ticks_msec() < last_evidence_time + get_evidence_cooldown():
		return;
	if randf() < get_evidence_probability():
		# Here's where you get the evidence type
		var evidences = get_leaveable_evidence_types();
		if evidences.size() == 0:
			return
		var evidence = evidences[randi() % evidences.size()];
		# Then place it
		if evidence == "meow":
			meow_sound.play();
		elif evidence == "paw":
			var new_paw = pawprint.instance();
			get_parent().add_child(new_paw);
			new_paw.position = position;
		elif evidence == "scratch":
			var new_scratch = scratch.instance();
			get_parent().add_child(new_scratch);
			new_scratch.position = position;
			print(new_scratch.get_parent())
	last_evidence_time = OS.get_ticks_msec();
	

onready var stats = get_node("CatStatBlock");

# Functions relating to the stats of the cat
func get_throw_strength():
	return stats.get_throw_strength();

func get_interaction_probability():
	return stats.get_interaction_probability();
	
func get_interaction_cooldown():
	return stats.get_interaction_cooldown();
	
func get_interaction_range():
	return stats.get_interaction_range();

func get_liked_objects():
	return stats.get_liked_objects();
	
func get_disliked_objects():
	return stats.get_disliked_objects();

func get_object_affinity(obj):
	if(get_liked_objects().has(obj)):
		return 1.5;
	elif(get_disliked_objects().has(obj)):
		return 0.66;
	else:
		return 1;

func get_evidence_probability():
	return stats.get_evidence_probability();

func get_evidence_cooldown():
	return stats.get_evidence_cooldown();
	

func get_evidence_types():
	return stats.get_evidence_types();

func get_leaveable_evidence_types():
	var arr = get_evidence_types();
	var results = [];
	for i in arr.size():
		if arr[i] == "scratch" or arr[i] == "meow" or arr[i] == "paw":
			results.push_back(arr[i]);
	return results;

func get_spite():
	return stats.get_spite();

func get_mobility():
	return stats.get_mobility();

func get_name():
	return stats.get_name();

func play_sit_loop():
	$AnimationPlayer.play("house_cat_picture_loop")


func take_photo():
	photographed = true
	if progress[0] and progress[1] and progress[2]:
		$WinTimer.start()
		print("you got the cat")
	else:
		$StunTimer.start()
	
	$Sprite.visible = true
	
	if get_name() == "ghost_house_cat":
		$AnimationPlayer.play("house_cat_picture")
	elif get_name() == "zombie_tiger":
		$AnimationPlayer.play("tiger_picture")
	elif get_name() == "lich_lynx":
		$AnimationPlayer.play("leopard_picture")
	else:
		$AnimationPlayer.play("witch_picture")


func _on_ObjectRange_body_entered(body):
	if body.is_thrown:
		impact_with_object(body)


func _on_WinTimer_timeout():
	get_parent().get_node("Player").get_node("UI").play_transition_screen(get_name())


func _on_StunTimer_timeout():
	photographed = false
	play_running_animation()
	$Sprite.visible = false

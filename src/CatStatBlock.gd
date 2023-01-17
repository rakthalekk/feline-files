extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize();


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var throw_strength = 1;
var interaction_probability = 1;
var interaction_cooldown = 1;
var interaction_range = 1;
var evidence_probability = 1;
var evidence_cooldown = 1;
var spite = 1;
var mobility = 1;
var cat_name = "";

var liked_objects = [];
var disliked_objects = [];

var evidence_types_list = ["meow","paw","orb","breath","scratch"]
var evidence_types = [];
const evidence_qty = 2;

func add_evidence_type():
	var new_evidence = evidence_types_list[randi() % evidence_types_list.size()];
	if evidence_types.has(new_evidence):
		add_evidence_type();
	else:
		evidence_types.push_back(new_evidence);

func generate(index):
	for i in evidence_qty:
		add_evidence_type();
	print(evidence_types);
	if index == 0: # Ghost House Cat
		cat_name = "ghost_house_cat";
		throw_strength = 1;
		interaction_probability = 0.5;
		interaction_cooldown = 5000;
		interaction_range = 100;
		evidence_probability = 0.3;
		evidence_cooldown = 5000;
		spite = 0.5;
		mobility = 5;
		disliked_objects = ["phone", "doorbell", "sink"];
		liked_objects = ["pool_ball", "scratch_post", "spoon","fork"]
	elif index == 1: # Zombie Tiger
		cat_name = "zombie_tiger";
		throw_strength = 5;
		interaction_probability = 0.2;
		interaction_cooldown = 10000;
		interaction_range = 150;
		evidence_probability = 0.3;
		evidence_cooldown = 10000;
		spite = 0.5;
		mobility = 0.5;
		disliked_objects = ["fridge", "phone"];
		liked_objects = ["television", "coffee_table", "side_table"]
	elif index == 2: # Lich Lynx
		cat_name = "lich_lynx";
		throw_strength = 2.5;
		interaction_probability = 0.35;
		interaction_cooldown = 7500;
		interaction_range = 120;
		evidence_probability = 0.35;
		evidence_cooldown = 7500;
		spite = 0.1;
		mobility = 3;
		disliked_objects = ["sink", "fridge"];
		liked_objects = ["curtain", "toaster", "scratch_post"]
	elif index == 3: # Witch Cat
		cat_name = "witch_cat";
		throw_strength = 1;
		interaction_probability = 0.75;
		interaction_cooldown = 5000;
		interaction_range = 100;
		evidence_probability = 0.5;
		evidence_cooldown = 5000;
		spite = 1;
		mobility = 3;
		disliked_objects = ["sink", "scratch_post", "cabinet"];
		liked_objects = ["toaster", "game_cabinet"]
	print("Hi, my name is " + get_name());

func get_name():
	return cat_name;

func get_throw_strength():
	return throw_strength;

func get_interaction_probability():
	return interaction_probability;
	
func get_interaction_cooldown():
	return interaction_cooldown;

func get_interaction_range():
	return interaction_range;

func get_liked_objects():
	return liked_objects;
	
func get_disliked_objects():
	return disliked_objects;

func get_evidence_probability():
	return evidence_probability;

func get_evidence_cooldown():
	return evidence_cooldown;

func get_evidence_types():
	return evidence_types;

func get_spite():
	return spite;

func get_mobility():
	return mobility;

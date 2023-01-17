extends Sprite


var cat_types = ["Unknown","Ghost House Cat", "Zombie Lion", "Lich Lynx", "Witch Cat"]
var evidence_types = ["Unknown","Hair Orb","Freezing Breath", "Scratches", "Ecto-Pawprint", "Spectral Meowing"]
var cat_cures = ["","Mouse","Steak","Fish","Broom"]
var e_cures = ["","Brush","Catbed","Yarn","Socks","Collar"]

var type_index = 0;
var e1_index = 0;
var e2_index = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func cat_left():
	type_index -= 1;
	if type_index < 0:
		type_index = cat_types.size() - 1;

func cat_right():
	type_index += 1;
	if type_index >= cat_types.size():
		type_index = 0;
	
func e1_left():
	e1_index -= 1;
	if e1_index < 0:
		e1_index = evidence_types.size() - 1;

func e1_right():
	e1_index += 1;
	if e1_index >= evidence_types.size():
		e1_index = 0;
	
func e2_left():
	e2_index -= 1;
	if e2_index < 0:
		e2_index = evidence_types.size() - 1;

func e2_right():
	e2_index += 1;
	if e2_index >= evidence_types.size():
		e2_index = 0;

func generate_items_needed():
	var result = "";
	if type_index != 0:
		result += cat_cures[type_index] + "\n";
	if e1_index != 0:
		result += e_cures[e1_index] + "\n";
	if e2_index != 0:
		result += e_cures[e2_index] + "\n";
	return result

func _process(delta):
	$TypeSelector.text = cat_types[type_index];
	$Evidence1.text = evidence_types[e1_index];
	$Evidence2.text = evidence_types[e2_index];
	$ItemList.text = generate_items_needed();

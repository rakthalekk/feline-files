extends Button

export var number = 0;
export var side = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _pressed():
	if number == 0 and side == 0:
		get_parent().cat_left();
	elif number == 0 and side == 1:
		get_parent().cat_right();
	elif number == 1 and side == 0:
		get_parent().e1_left();
	elif number == 1 and side == 1:
		get_parent().e1_right();
	elif number == 2 and side == 0:
		get_parent().e2_left();
	elif number == 2 and side == 1:
		get_parent().e2_right();

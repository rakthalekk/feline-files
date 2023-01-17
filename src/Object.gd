class_name ObjectInteractable
extends KinematicBody2D


export var can_be_picked_up = false;
export var object_name = "";

var is_thrown = false

onready var throw_timer := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var object_manager = get_parent().get_node("ObjectManager");
	object_manager.add_object(self);
	
	add_child(throw_timer)
	throw_timer.wait_time = 3.0
	throw_timer.one_shot = true
	throw_timer.connect("timeout", self, "_on_timer_timeout")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide(velocity);
	if get_slide_count() > 1:
		var collision = get_slide_collision(1);
		velocity = 0.5 * velocity.bounce(collision.normal);
		var collider = collision.collider;
		
		if collider is Cat:
			collider.impact_with_object(self);
	velocity *= 0.9;

var velocity = Vector2.ZERO;


func interact(interactor):
	get_node("AudioStreamPlayer2D").play();
	velocity = interactor.get_throw_strength() * (position - interactor.position).normalized() * 100;


func player_examine():
	# will add some entry to notebook
	if can_be_picked_up:
		get_parent().get_node("Player").pick_up_item(self);

func get_name():
	return object_name;


func _on_timer_timeout() -> void:
	is_thrown = false
	print("timeout")

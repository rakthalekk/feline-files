extends KinematicBody2D


var velocity = Vector2.ZERO
export var speed = 100

const GHOST_DETECTOR = preload("res://src/GhostDetector.tscn")

var current_tool = "camera"

var tool_list = ["laser_pointer", "ghost_detector", "camera"]

var using_camera = false

var direction = Vector2.ZERO

var cat_in_range = null

var last_ghost_detector = null

onready var anim_player = $AnimationPlayer
onready var event_animation = $EventAnimation
onready var flashlight_animation = $FlashlightAnimation
onready var breath_animation = $BreathAnimation

onready var room_manager = get_parent().get_node("RoomManager");
onready var cat = get_parent().get_node("Cat")

var current_room = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	current_room = room_manager.get_room_at_position(position)
	if get_parent().get_node("Cat").get_evidence_types().has("breath"):
		if current_room != null && current_room == cat.current_room:
			breath_animation.play("breath")
	
	get_input()
	
	if !using_camera:
		direction = get_direction().normalized()
	
		velocity = direction * speed
	
		move_and_slide(velocity)
	
	handle_footstep_sounds();
	
	if Global.uvmode:
		get_node("ViewCone/Light2D").color = Color.violet;
	else:
		get_node("ViewCone/Light2D").color = Color.white;
	
	if using_camera:
		if direction.x > 0:
			anim_player.play("camera_right")
		elif direction.x < 0:
			anim_player.play("camera_left")
		elif direction.y > 0:
			anim_player.play("camera_down")
		elif direction.y < 0:
			anim_player.play("camera_up")
		return
	
	if direction.x > 0:
		anim_player.play("walking_right")
	elif direction.x < 0:
		anim_player.play("walking_left")
	elif direction.y > 0:
		anim_player.play("walking_down")
	elif direction.y < 0:
		anim_player.play("walking_up")
	elif anim_player.current_animation == "walking_right":
		anim_player.play("idle_right")
	elif anim_player.current_animation == "walking_left":
		anim_player.play("idle_left")
	elif anim_player.current_animation == "walking_down":
		anim_player.play("idle_down")
	elif anim_player.current_animation == "walking_up":
		anim_player.play("idle_up")



func handle_footstep_sounds():
	if velocity == Vector2.ZERO:
		get_node("CarpetSound").stop();
		get_node("WoodSound").stop();
		get_node("TileSound").stop();
	if current_room == null:
		get_node("CarpetSound").stop();
		if !get_node("WoodSound").is_playing():
			get_node("WoodSound").play();
		get_node("TileSound").stop();
		return;
	var room_name = current_room.room_name;
	if room_name == "kitchen" or room_name == "bathroom" or room_name == "garage":
		get_node("CarpetSound").stop();
		get_node("WoodSound").stop();
		if !get_node("TileSound").is_playing():
			get_node("TileSound").play();
	elif room_name == "bedroom" or room_name == "recreation_room" or room_name == "hallway":
		if !get_node("CarpetSound").is_playing():
			get_node("CarpetSound").play();
		get_node("WoodSound").stop();
		get_node("TileSound").stop();
	else:
		get_node("CarpetSound").stop();
		if !get_node("WoodSound").is_playing():
			get_node("WoodSound").play();
		get_node("TileSound").stop();

func get_input():
	if using_camera:
		return
	if Input.is_action_just_pressed("move_right"):
		flashlight_animation.play("flashlight_right")
	elif Input.is_action_just_pressed("move_down"):
		flashlight_animation.play("flashlight_down")
	elif Input.is_action_just_pressed("move_left"):
		flashlight_animation.play("flashlight_left")
	elif Input.is_action_just_pressed("move_up"):
		flashlight_animation.play("flashlight_up")
	elif Input.is_action_just_released("move_right") || Input.is_action_just_released("move_down") || Input.is_action_just_released("move_left") || Input.is_action_just_released("move_up"):
		if Input.is_action_pressed("move_right"):
			flashlight_animation.play("flashlight_right")
		elif Input.is_action_pressed("move_down"):
			flashlight_animation.play("flashlight_down")
		elif Input.is_action_pressed("move_left"):
			flashlight_animation.play("flashlight_left")
		elif Input.is_action_pressed("move_up"):
			flashlight_animation.play("flashlight_up")
	
	if Input.is_action_just_pressed("interact"):
		event_animation.play("interact")
	if Input.is_action_just_pressed("camera"):
		current_tool = "camera"
		$ViewCone.get_node("CameraRange").visible = true
	if Input.is_action_just_pressed("laser_pointer"):
		current_tool = "laser_pointer"
		$ViewCone.get_node("CameraRange").visible = false
	if Input.is_action_just_pressed("ghost_detector"):
		current_tool = "ghost_detector"
		$ViewCone.get_node("CameraRange").visible = false
	if Input.is_action_just_pressed("item_1") && get_node("UI").items.size() > 0:
		current_tool = "1"
		$ViewCone.get_node("CameraRange").visible = false
	if Input.is_action_just_pressed("item_2") && get_node("UI").items.size() > 1:
		current_tool = "2"
		$ViewCone.get_node("CameraRange").visible = false
	if Input.is_action_just_pressed("item_3") && get_node("UI").items.size() > 2:
		current_tool = "3"
		$ViewCone.get_node("CameraRange").visible = false
	if Input.is_action_just_released("scroll_up"):
		var new_index = tools.slice(0,2 + items.size()).find(current_tool) - 1;
		print(new_index)
		if new_index < 0:
			new_index += 3 + items.size();
		current_tool = tools.slice(0,2 + items.size())[new_index]
		if current_tool == "camera":
			$ViewCone.get_node("CameraRange").visible = true
		else:
			$ViewCone.get_node("CameraRange").visible = false
		
	if Input.is_action_just_released("scroll_down"):
		var new_index = tools.slice(0,2 + items.size()).find(current_tool) + 1;
		if new_index >= 3 + items.size():
			new_index -= 3 + items.size();
		current_tool = tools.slice(0,2 + items.size())[new_index]
		if current_tool == "camera":
			$ViewCone.get_node("CameraRange").visible = true
		else:
			$ViewCone.get_node("CameraRange").visible = false
	
	
	use_tool()
	
	if Input.is_action_just_pressed("uv"):
		if (!Global.uvmode):
			Global.uvmode = true
		else:
			Global.uvmode = false

var tools = ["camera","laser_pointer","ghost_detector","1","2","3"]

func use_tool():
	if Input.is_action_just_pressed("use_tool"):
		if current_tool == "ghost_detector":
			if last_ghost_detector:
				last_ghost_detector.queue_free()
			
			var detector = GHOST_DETECTOR.instance()
			detector.position = position
			last_ghost_detector = detector
			get_parent().get_parent().get_node("Traps").add_child(detector)
		elif current_tool == "camera":
			$CameraFlash.get_node("AnimationPlayer").play("flash")
			get_node("CameraSound").play();
			using_camera = true
			
			if cat_in_range:
				cat_in_range.take_photo()
		elif current_tool == "1":
			throw_item(0);
		elif current_tool == "2":
			throw_item(1);
		elif current_tool == "3":
			throw_item(2);
	
	
	if Input.is_action_pressed("use_tool") && current_tool == "laser_pointer":
		if !$Beam.is_casting:
			$Beam.set_is_casting(true)
		$Beam.cast_to = get_local_mouse_position()
	if Input.is_action_just_released("use_tool"):
		$Beam.set_is_casting(false)


func get_direction(): #get direction of the character 
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

var items = [];

func pick_up_item(item):
	if(items.size() == 3):
		return;
	items.push_back(item);
	item.get_parent().remove_child(item);
	
func place_item(index):
	var item = items[index];
	items.remove(index);
	get_parent().add_child(item);
	item.position = position;
	get_node("UI").remove_item(index);
	
func throw_item(index):
	if index > items.size() - 1:
		return
	var item = items[index];
	items.remove(index);
	get_parent().add_child(item);
	item.position = position;
	get_node("UI").remove_item(index);
	var vel = (get_local_mouse_position()).normalized() * 2000;
	current_tool = "camera"
	item.velocity = vel;
	$ViewCone.get_node("CameraRange").visible = true
	
	item.is_thrown = true
	item.throw_timer.start()

func _on_InteractCollider_body_entered(body):
	if body is ObjectInteractable:
		body.player_examine()
		
		
func _on_ViewCone_area_entered(area):
	if area is GhostOrb && current_tool == "camera":
		area.visible = true
	elif area is EctoPawprints:
		if (!area.instance):
			area.instance += 1
	


func _on_ViewCone_area_exited(area):
	if area is GhostOrb:
		area.visible = false
	elif area is EctoPawprints:
		if (area.instance):
			area.instance -= 1
		


func stop_using_camera():
	using_camera = false


func _on_ViewCone_body_entered(body):
	if body is Cat:
		cat_in_range = body


func _on_ViewCone_body_exited(body):
	if body is Cat:
		cat_in_range = null

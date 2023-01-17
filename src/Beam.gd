# This program uses code from the "Make a Laser Beam in Godot in 1 Minute video by GDQuest.
# CC-By 4.0 - GDQuest and contributors - https://www.gdquest.com/
class_name Beam
extends RayCast2D

export var is_casting := true setget set_is_casting

var laser_position = Vector2.ZERO

onready var line = $"Line2D"
onready var parent = $".."


func _ready():
	set_is_casting(false)
	set_physics_process(is_casting)
	line.points[1] = Vector2.ZERO


func _physics_process(delta):
	var cast_point := cast_to
	force_raycast_update()
	
	if is_colliding():
		var collider = get_collider()
		cast_point = to_local(get_collision_point())
	
	line.points[1] = cast_point
	laser_position = global_position + cast_point
	#print(laser_position)


func set_is_casting(cast: bool):
	is_casting = cast
	
	if is_casting:
		appear()
	else:
		disappear()
	set_physics_process(is_casting)


func appear():
	$Tween.stop_all()
	$Tween.interpolate_property(line, "width", 0, 5.0, 0.2)
	$Tween.start()


func disappear():
	$Tween.stop_all()
	$Tween.interpolate_property(line, "width", 5.0, 0, 0.1)
	$Tween.start()


func enable():
	set_is_casting(true)


func disable():
	set_is_casting(false)


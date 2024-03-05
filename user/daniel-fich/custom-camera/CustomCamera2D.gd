extends Camera2D

@export var player : Node
@export var velocity_scaling_x : float = 0.05
@export var velocity_scaling_positive_y : float = 0.025
@export var velocity_scaling_negative_y : float = 0

var current_camera_area: CameraArea
var camera_areas: Array

var bound_node : Node
var bound_offset : Vector2
var target : Vector2
var target_offset : Vector2
var target_offset_target : Vector2

var intended_camera_position: Vector2

var lerp_speed: float

var zoom_target: Vector2
var zoom_speed: float

func _ready():
	current_camera_area = null
	camera_areas = Array()
	
	target = player.global_position
	global_position = target
	intended_camera_position = global_position
	
	target_offset = Vector2(0, 0)
	target_offset_target = Vector2(0, 0)
	
	set_camera_area_values(null)
	
	disable_main_camera()

func disable_main_camera():
	player.get_node("Camera2D").enabled = false

func _process(delta):
	zoom = zoom.lerp(zoom_target, delta * zoom_speed)
	
	target_offset = target_offset.lerp(target_offset_target, delta * 5)
	
	target = player.global_position + target_offset + get_velocity_offset()
	
	keep_target_in_bounds(delta)
	
	intended_camera_position = intended_camera_position.lerp(target, delta * lerp_speed)
	global_position = intended_camera_position #round(intended_camera_position)

func get_velocity_offset():
	var x = player.velocity.x * velocity_scaling_x
	var y
	if player.velocity.y < 0:
		y = player.velocity.y * velocity_scaling_negative_y
	else:
		y = player.velocity.y * velocity_scaling_positive_y
	
	return Vector2(x, y)

func keep_target_in_bounds(delta):
	if bound_node == null:
		return
	
	var min_target = bound_node.global_position
	var max_target = min_target + bound_offset
	
	target = real_clamp(target, min_target, max_target)

func real_clamp(vec: Vector2, v1: Vector2, v2: Vector2):
	var min_x = min(v1.x, v2.x)
	var max_x = max(v1.x, v2.x)
	
	var min_y = min(v1.y, v2.y)
	var max_y = max(v1.y, v2.y)

	var min_v = Vector2(min_x, min_y)
	var max_v = Vector2(max_x, max_y)
	return vec.clamp(min_v, max_v)
func min(a: float, b: float):
	if a < b:
		return a
	return b
func max(a: float, b: float):
	if a < b:
		return b
	return a

func set_camera_offset(camera_area: CameraArea, entered: bool):
	if entered:
		camera_areas.push_front(camera_area)
		current_camera_area = camera_areas.back()
		set_camera_area_values(current_camera_area)
	else:
		var remove_index = camera_areas.find(camera_area)
		if remove_index != -1:
			camera_areas.remove_at(remove_index)
		if (camera_areas.size() == 0):
			current_camera_area = null
		else:
			current_camera_area = camera_areas.back()
		set_camera_area_values(current_camera_area)

func set_camera_area_values(camera_area: CameraArea):
	if camera_area == null:
		target_offset_target = Vector2.ZERO
		bound_node = null
		bound_offset = Vector2.ZERO
		lerp_speed = 5
		zoom_target = Vector2.ONE
		zoom_speed = 5
	else:
		target_offset_target = camera_area.area_offset
		bound_node = camera_area.bound_node
		bound_offset = camera_area.bound_offset
		lerp_speed = camera_area.lerp_speed
		zoom_target = camera_area.zoom
		zoom_speed = camera_area.zoom_speed
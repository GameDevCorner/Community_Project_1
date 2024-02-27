extends Camera2D

@export var player : Node

var bound_node : Node
var bound_offset : Vector2
var target : Vector2
var target_offset : Vector2
var target_offset_target : Vector2

func _ready():
	bound_node = player
	target = bound_node.position
	position = target
	
	target_offset = Vector2(0, 0)
	target_offset_target = Vector2(0, 0)
	
	disable_main_camera()

func disable_main_camera():
	player.get_node("Camera2D").enabled = false

func _process(delta):
	target = player.position + target_offset
	
	keep_target_in_bounds()
	
	target_offset = target_offset.lerp(target_offset_target, delta * 5)
	position = position.lerp(target, delta * 5)

func keep_target_in_bounds():
	if bound_node == null:
		return
	
	var min_target = bound_node.position
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

func set_camera_offset(new_offset = Vector2.ZERO, new_target: Node = null, new_bound_offset = Vector2.ZERO):
	target_offset_target = new_offset
	bound_node = new_target
	bound_offset = new_bound_offset


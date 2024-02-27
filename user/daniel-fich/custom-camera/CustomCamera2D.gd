extends Camera2D

@export var player : Node

var target_node : Node
var target : Vector2
var target_offset : Vector2
var target_offset_target : Vector2

func _ready():
	#position = player.position 
	#target = player.position
	target_node = player
	target = target_node.position
	position = target
	target_offset = Vector2(0, 0)
	target_offset_target = Vector2(0, 0)
	
	disable_main_camera()

func disable_main_camera():
	player.get_node("Camera2D").enabled = false

func _process(delta):
	target = target_node.position + target_offset
	target_offset = target_offset.lerp(target_offset_target, delta * 5)
	position = position.lerp(target, delta * 5)


func set_camera_offset(new_offset = Vector2.ZERO, new_target: Node = null):
	target_offset_target = new_offset
	print(new_target)
	if new_target == null:
		target_node = player
	else:
		target_node = new_target
	
	#target_node = player


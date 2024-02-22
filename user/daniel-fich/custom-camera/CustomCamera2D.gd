extends Camera2D

@export var player : Node

var target : Vector2
var target_offset : Vector2
var target_offset_target : Vector2

func _ready():
	position = player.position 
	target = player.position
	target_offset = Vector2(0, 0)
	target_offset_target = Vector2(0, 0)
	
	disable_main_camera()

func disable_main_camera():
	player.get_node("Camera2D").enabled = false

func _process(delta):
	target = player.position + target_offset
	target_offset = target_offset.lerp(target_offset_target, delta * 5)
	position = position.lerp(target, delta * 5)


func set_camera_offset(new_offset = Vector2.ZERO):
	target_offset_target = new_offset


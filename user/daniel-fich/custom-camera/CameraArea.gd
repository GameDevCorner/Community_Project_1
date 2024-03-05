extends Area2D

class_name CameraArea

@export_category("Area")
@export var area_offset: Vector2
@export var bound_node: Node
@export var bound_offset: Vector2

@export_category("Lerp")
@export var lerp_speed: float = 5

@export_category("Zoom")
@export var zoom: Vector2 = Vector2.ONE
@export var zoom_speed: float = 5

signal camera_area_entered(camera_area: CameraArea, entered: bool)


func _ready():
	print("ready") 

func _process(delta):
	pass

func _on_body_entered(body):
	if body.get_name() == "Player":
		camera_area_entered.emit(self, true)


func _on_body_exited(body):
	if body.get_name() == "Player":
		camera_area_entered.emit(self, false)
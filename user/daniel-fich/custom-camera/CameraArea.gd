extends Area2D

@export var area_offset : Vector2
@export var target : Node

signal camera_area_entered(new_offset: Vector2, target: Node)


func _ready():
	pass 

func _process(delta):
	pass

func _on_body_entered(body):
	if body.get_name() == "Player":
		camera_area_entered.emit(area_offset, target)


func _on_body_exited(body):
	if body.get_name() == "Player":
		camera_area_entered.emit()

extends Area2D

@export var area_offset : Vector2

signal camera_area_entered(new_offset: Vector2)


func _ready():
	pass 

func _process(delta):
	pass

func _on_body_entered(body):
	if body.get_name() == "Player":
		camera_area_entered.emit(area_offset)


func _on_body_exited(body):
	if body.get_name() == "Player":
		camera_area_entered.emit()

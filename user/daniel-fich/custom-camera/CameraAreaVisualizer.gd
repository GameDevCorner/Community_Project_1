@tool
extends Node2D

func _draw():
	print(get_viewport_rect().size)
	
	draw_dashed_line(Vector2.ZERO, Vector2(50, 50), Color(255, 0, 0))

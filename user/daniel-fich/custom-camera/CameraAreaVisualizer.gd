@tool
extends Node2D

func _draw():
	if not Engine.is_editor_hint():
		return
	
	# This is the size of the current display: get_viewport_rect()
	
	var screen_width = 480 # ProjectSettings - display/window/size/viewport_width
	var screen_height = 270 # ProjectSettings - display/window/size/viewport_height
	
	screen_width *= 1 / get_parent().zoom.x
	screen_height *= 1 / get_parent().zoom.y
	
	var bound_offset = get_parent().bound_offset
	var player_offset = get_parent().player_offset
	
	draw_player_offset(player_offset)
	
	if get_parent().bound_node == get_parent():
		draw_screen_outlines(screen_width, screen_height, bound_offset)
		draw_free_area(bound_offset)

func draw_screen_outlines(screen_width: float, screen_height: float, bound_offset: Vector2):
	var screen_top_left = Vector2(-screen_width/2, -screen_height/2)
	var screen_size = Vector2(screen_width, screen_height)
	
	var screen_rect = Rect2(screen_top_left, screen_size)
	
	var screen_area_top_left = screen_top_left + bound_offset.clamp(Vector2(-1.79769e308, -1.79769e308), Vector2.ZERO)
	var screen_area_size = screen_size + abs(bound_offset)
	
	var screen_area_rect = Rect2(screen_area_top_left, screen_area_size)
	
	draw_rect(screen_area_rect, Color.RED, false, 1.5)
	draw_rect(screen_rect, Color.GREEN, false, 2)

func draw_free_area(bound_offset: Vector2):
	var rect = Rect2(Vector2.ZERO, bound_offset)
	draw_rect(rect, Color.YELLOW, false, 1)

func draw_player_offset(player_offset: Vector2):
	draw_dashed_line(Vector2.ZERO, player_offset, Color.RED)

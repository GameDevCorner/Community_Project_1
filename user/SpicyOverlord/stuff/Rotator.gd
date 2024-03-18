extends Area2D

@export var right_way = true

var player
var can_rotate_player = true

@onready var timer = Timer.new()

func _ready():
	player = Levelmanager.get_player()
	
	add_child(timer)
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.connect("timeout", _on_Timer_timeout)

func _process(delta):
	if can_rotate_player:
		var rotate_distance = delta * 50
		if right_way:
			rotation_degrees -= rotate_distance
			#rotate(rotate_distance)
		else:
			rotation_degrees += rotate_distance
			#rotate(-rotate_distance)

func _on_rotator_body_entered(body):
	if body == player and can_rotate_player:
		player.rotate_gravity(right_way, position)
		can_rotate_player = false 
		timer.start() 
		
func _on_Timer_timeout():
	can_rotate_player = true 

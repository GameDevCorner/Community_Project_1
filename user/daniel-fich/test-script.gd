extends Node2D

var player

func _ready():
	player = get_parent()
	player.get_node("Camera2D").offset.y = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#player.velocity.y = clamp(player.velocity.y, -100000000000, 100)
	pass

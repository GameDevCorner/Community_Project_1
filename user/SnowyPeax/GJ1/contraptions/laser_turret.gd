extends StaticBody2D

@export var range = 300
@onready var player = Levelmanager.get_player()

var firing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	follow_player()

func follow_player():
	if firing: return
	var dir = player.global_position - $Cannon.global_position
	$Cannon.rotation = dir.angle()

func fire():
	firing = true
	var player_pos = player.global_position

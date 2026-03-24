extends StaticBody2D

@export var projectile : PackedScene
@export var firing_speed = 10
@export var range = 150
@onready var player = Levelmanager.get_player()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (player.global_position - global_position).length() < range:
		$AnimationPlayer.play("spot_player")
	else:
		$AnimationPlayer.play("player_gone")

func fire():
	var charge = projectile.instantiate()
	charge.position = $Head.position
	charge.velocity = (player.global_position - $Head.global_position).rotated(-rotation)
	add_child(charge)

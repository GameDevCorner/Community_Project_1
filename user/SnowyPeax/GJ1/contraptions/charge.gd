extends Area2D

@export var velocity : Vector2
@export var speed = 30
@onready var player = Levelmanager.get_player()

func _ready():
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity.normalized() * speed * delta




func _on_body_entered(body):
	if body == player:
		player.die()
		


func _on_timer_timeout():
	queue_free()

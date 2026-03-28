extends CharacterBody2D

class_name spicy_player

@export var speed = 4000.0
@export var jump_velocity = -100.0
@export var friction = 20

var dir = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var current_gravity = Vector2.DOWN
@onready var y_gravity = true

@onready var animations = $AnimatedSprite2D

func _ready():
	Levelmanager._player = self

func apply_force(force: Vector2):
	velocity += force

func _process(delta):
	apply_physics(delta)
	move_and_slide()

func apply_physics(delta):
	# if global_position.y > 500 or global_position.y < -500 or global_position.x > 500 or global_position.x < -500:
	#   die()
	
	#Apply Friction
	if y_gravity:
		velocity.x *= 1 - (friction * delta)
	else:
		velocity.y *= 1 - (friction * delta)
	
	#Apply Gravity
	velocity.x += current_gravity.x * gravity * delta * 0.5
	velocity.y += current_gravity.y * gravity * delta * 0.5

func _physics_process(delta): 
	var is_gravity_grounded = (y_gravity and (is_on_floor() or is_on_ceiling())) or (not y_gravity and is_on_wall())
	var is_trying_to_jump = (y_gravity and dir.y == -1 * current_gravity.y or not y_gravity and dir.y == -1* current_gravity.x) 
	
	if is_trying_to_jump and is_gravity_grounded:
		change_animation("fall")
		
		apply_force(Vector2(jump_velocity * current_gravity.x, jump_velocity * current_gravity.y))
		
		if y_gravity:
			flip_v(current_gravity.y == 1)
		else:
			flip_h(current_gravity.x == 1)
		
		current_gravity *= -1

	elif is_gravity_grounded:
		if dir:
			change_animation("move")
		else:
			change_animation("idle")
		
	if dir:
		if y_gravity:
			flip_h(dir.x != 1)
		else:
			flip_v(dir.x == 1)

	velocity.x += abs(current_gravity.y) * speed * dir.x * delta
	velocity.y += abs(current_gravity.x) * speed * dir.x * delta

func rotate_gravity(right_way, pos):
	velocity = Vector2.ZERO
	position = pos
	#$AnimatedSprite2D.position = Vector2.ZERO
	
	if right_way:
		current_gravity = Vector2(current_gravity.y, -current_gravity.x)
	else:
		current_gravity = Vector2(-current_gravity.y, current_gravity.x)
	
	if rotation_degrees == 0:
		rotation_degrees = -90
	else:
		rotation_degrees = 0

	if right_way:
		flip_h(current_gravity.y != 1)
	else:
		flip_v(current_gravity.x != 1)
	
	y_gravity = not y_gravity

func die():
	Levelmanager.reload_from_checkpoint()

func _input(_event):
	dir = Input.get_vector("left", "right", "up", "down")
	
	if current_gravity.y != 0:
		dir = Vector2(round(dir.x), round(dir.y))
	else:
		dir = Vector2(round(dir.y), round(dir.x))

func change_animation(animation_name: String):
	if animations != null:
		animations.play(animation_name)

func flip_h(_d):
	if y_gravity:
		$AnimatedSprite2D.scale.x = -1 if _d else 1
	else:
		$AnimatedSprite2D.scale.y = -1 if _d else 1
		$AnimatedSprite2D.position.y = 6 if _d else 0
		
func flip_v(_d):
	if y_gravity:
		$AnimatedSprite2D.scale.y = -1 if _d else 1
		$AnimatedSprite2D.position.y = 12 if _d else 0
	else:
		$AnimatedSprite2D.scale.x = -1 if _d else 1


	

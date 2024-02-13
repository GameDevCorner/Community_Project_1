extends CharacterBody2D

class_name player

@export var speed = 2000.0
@export var aerial_speed = 1700
@export var max_wallslide_speed = 200
@export var jump_velocity = -400.0
@export var wall_jump_velocity = Vector2(400, -330)
@export var good_wall_jump_velocity = Vector2(475, -350)
@export var friction = 10
@export var fastfallmult = 1.5
@export var medfallmult = 1.15
@export var coyote_time = 0.05 # In seconds

@onready var feet = $Feet
@export var back : Marker2D
var dir = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var states = $StateMachine
@onready var animations = $AnimatedSprite2D


var coyote_timer = 0.0

func apply_force(force : Vector2):
	velocity += force

func _physics_process(delta):
	apply_physics(delta)
	
	# Update coyote timer
	if is_on_floor():
		coyote_timer = coyote_time
	else:
		coyote_timer -= delta
	
	move_and_slide()

func apply_physics(delta):
	if global_position.y > 500:
		die()
	
	#Apply Friction
	velocity.x *= 1 - (friction * delta)
	
	#Apply Gravity
	velocity.y += gravity * delta

func die():
	print("Player died!")
	Levelmanager.reload_scene()
	Levelmanager.time_elapsed = 0

func _input(_event):
	dir = Input.get_vector("left", "right", "up", "down")
	dir = Vector2(round(dir.x), round(dir.y))
	
	# Check for jump input with coyote time
	if _event.is_action_pressed("jump") and (coyote_timer > 0 or is_on_floor()):
		jump()

func jump():
	velocity.y = jump_velocity

func change_animation(animation_name : String):
	if animations != null:
		animations.play(animation_name)

func flip_h(_d):
	$AnimatedSprite2D.scale.x = -1 if _d else 1

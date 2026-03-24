extends Area2D

@export var boost_angle: int

var rotate_speed=500

var player

var force = 600

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_CTRL:
			increment_angle(-45)
		if 	event.keycode == KEY_SHIFT:
			increment_angle(45)
		

func _process(delta):
	if abs(int($Sprite2D.rotation_degrees) % 360 - boost_angle)>5:
		var direction =-sign(int($Sprite2D.rotation_degrees) % 360-boost_angle)
		if boost_angle ==0:
			if $Sprite2D.rotation_degrees>180:
				direction=1
			else:
				direction=-1	
			
		if 	$Sprite2D.rotation_degrees==0 and boost_angle>180:
			direction=-1
			$Sprite2D.rotation_degrees=359
		
		
		$Sprite2D.rotation_degrees+= direction*delta*rotate_speed	
	else: 
		$Sprite2D.rotation_degrees=boost_angle		
		
		

func _ready():
	$Sprite2D.rotation_degrees = boost_angle
	player = Levelmanager.get_player()
	
	
	
func _on_body_entered(body):
	if body == player:
		player.velocity=degrees_to_vector(boost_angle)*force
		player.velocity.x*=1.5	
		$GPUParticles2D.emitting=true
		$GPUParticles2D.rotation_degrees=boost_angle
		
	

func increment_angle(amount):
		if amount<0 and boost_angle==0:
			boost_angle=360
		boost_angle = (boost_angle + amount) % 360
			
	

func degrees_to_vector(degrees):
	
	if degrees == 0 :
		return Vector2(0,-1)
	if degrees== 45:
		return Vector2(1,-1).normalized()
	if degrees==90:
		return 	Vector2(1,0)
	if degrees==135:
		return Vector2(-1,1).normalized()	
	if degrees==180:
		return 	Vector2(0,1)
	if degrees==225:
		return Vector2(-1,1).normalized()
	if degrees==270:
		return Vector2(-1,0)
	if degrees==315:
		return Vector2(-1,-1).normalized()				
	

		

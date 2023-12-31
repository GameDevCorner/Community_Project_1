extends state


func on_state_entered():
	player.change_animation("move")


func _physics_process(delta):
	if Input.is_action_just_pressed("jump"):
		state_machine.change_to_state("Jump")
	if !player.dir:
		state_machine.change_to_state("Idle")
	else:
		player.flip_h(player.dir.x != 1)
	if !player.is_on_floor():
		state_machine.change_to_state("Fall")
	
	player.velocity.x += player.speed * player.dir.x * delta

extends Node

@export var default_state : state

var current_state : state

func _ready():
	for child in get_children():
		child.state_machine = self
		child.player = get_parent()
	current_state = default_state
	current_state.enter()

func change_to_state(new_state : String):
	change_to_state_node(get_state(new_state))

func change_to_state_node(new_state : state):
	current_state.exit()
	current_state = new_state
	current_state.enter()

func get_state(state_name : String):

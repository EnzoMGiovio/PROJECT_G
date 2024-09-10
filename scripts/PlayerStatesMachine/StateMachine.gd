# StateMachine.gd
extends Node

@onready var player = get_parent()
@onready var current_state: State

func initialize() -> void:
	for child in get_children():
		child.player = player
	
	current_state = get_node("Idle")
	current_state.enter()

func change_state(new_state_name: String) -> void:
	if current_state:
		current_state.exit()
	
	current_state = get_node(new_state_name)
	current_state.enter()

func handle_input(event: InputEvent) -> void:
	current_state.handle_input(event)

func update(delta: float) -> void:
	current_state.update(delta)

func physics_update(delta: float) -> void:
	current_state.physics_update(delta)

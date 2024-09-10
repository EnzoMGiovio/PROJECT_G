# EnemyStateMachine.gd
extends Node

var enemy: CharacterBody2D
var current_state: EnemyState

func initialize(enemy_node: CharacterBody2D) -> void:
	self.enemy = enemy_node
	for child in get_children():
		child.enemy = enemy_node
	
	change_state("Idle")

func change_state(new_state_name: String) -> void:
	if current_state:
		current_state.exit()
	
	current_state = get_node(new_state_name)
	current_state.enter()

func physics_update(delta: float) -> void:
	current_state.physics_update(delta)

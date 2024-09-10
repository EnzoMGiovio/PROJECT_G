# WalkState.gd
extends State

func physics_update(delta: float) -> void:
	player.handle_movement()
	player.handle_rotation(delta)
	if player.velocity.length() < 0.1:
		get_parent().change_state("Idle")
	elif Input.is_action_just_pressed("shoot"):
		get_parent().change_state("Attack")

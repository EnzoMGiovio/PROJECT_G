# IdleState.gd
extends State

func enter() -> void:
	player.velocity = Vector2.ZERO
	# Aquí podrías activar una animación de idle

func update(delta: float) -> void:
	player.handle_rotation(delta)
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or \
	   Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down"):
		get_parent().change_state("Walk")
	elif Input.is_action_just_pressed("shoot"):
		get_parent().change_state("Attack")

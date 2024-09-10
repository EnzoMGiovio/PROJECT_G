# AttackState.gd
extends State

func enter() -> void:
	player.shoot_bullet()
	# Aquí podrías activar una animación de ataque

func update(_delta: float) -> void:
	# Cambia al estado idle después de un corto período o al finalizar la animación
	get_parent().change_state("Idle")

# HurtState.gd

extends EnemyState

var hurt_timer: float = 0.5

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	# Aquí podrías activar una animación de daño
	print("Enemy entered Hurt state")

func physics_update(delta: float) -> void:
	hurt_timer -= delta
	if hurt_timer <= 0:
		if enemy.is_dead():
			get_parent().change_state("Death")
		else:
			get_parent().change_state("Chase")

func exit() -> void:
	hurt_timer = 0.5  # Reinicia el temporizador para la próxima vez

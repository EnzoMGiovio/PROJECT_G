# DeathState.gd

extends EnemyState

func enter() -> void:
	enemy.velocity = Vector2.ZERO
	# Aquí podrías activar una animación de muerte
	print("Enemy entered Death state")
	# Puedes agregar un temporizador si quieres que el enemigo permanezca visible por un tiempo antes de desaparecer
	enemy.queue_free()

# No necesitamos physics_update aquí, ya que el enemigo está muerto y será eliminado

# IdleState.gd
extends EnemyState

func enter() -> void:
	enemy.velocity = Vector2.ZERO

func physics_update(_delta: float) -> void:
	enemy.move_and_slide()

# ChaseState.gd
extends EnemyState

func enter() -> void:
	print("Entering Chase State")  # Para depuración

func physics_update(delta: float) -> void:
	if enemy.player:
		var direction = (enemy.player.global_position - enemy.global_position).normalized()
		enemy.velocity = direction * enemy.speed
		enemy.move_and_slide()
		
	else:
		get_parent().change_state("Idle")

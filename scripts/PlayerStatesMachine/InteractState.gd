# InteractState.gd
extends State

func enter(_msg := {}) -> void:
	if owner.interactable_object and owner.interactable_object.has_method("interact"):
		owner.interactable_object.interact(owner)
	else:
		print("No hay objeto interactuable válido")
	
	# Automáticamente vuelve al estado Idle después de interactuar
	get_parent().change_state("Idle")

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

# InteractState.gd
extends State

func enter(_msg := {}) -> void:
	if owner.interactable_object and owner.interactable_object.has_method("interact"):
		var result = owner.interactable_object.interact(owner)
		if result is String:  # Asumimos que si devuelve un String, es el nombre de un item para añadir al inventario
			if owner.add_to_inventory(result):
				print("Item {result} añadido al inventario")
			else:
				print("No se pudo añadir el item al inventario")
	else:
		print("No hay objeto interactuable válido")
	
	# Automáticamente vuelve al estado Idle después de interactuar
	get_parent().change_state("Idle")

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

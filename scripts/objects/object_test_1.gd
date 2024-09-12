# Chest.gd
extends Node2D

@onready var object_area: Area2D = $ObjectArea

func _ready() -> void:
	object_area.add_to_group("interactable")

func interact(interactor: Node) -> void:
	print("¡El jugador ha abierto el cofre!")
	# Aquí puedes añadir la lógica específica del cofre

# Enemy.gd
extends CharacterBody2D

@export var speed: float = 100.0
@export var max_health: int = 5
@export var detection_radius: float = 200.0

var player: Node2D
var current_health: int

@onready var state_machine: Node = $EnemyStateMachine

func _ready() -> void:
	player = get_node_or_null("/root/World/Player")
	current_health = max_health
	state_machine.initialize(self)
	
	$HitboxArea.connect("area_entered", Callable(self, "_on_hitbox_area_entered"))

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		take_damage(1)  # Asume que cada bala hace 1 de daño

func take_damage(amount: int) -> void:
	current_health -= amount
	print("Enemy health: ", current_health)  # Para depuración
	if current_health <= 0:
		state_machine.change_state("Death")
	else:
		state_machine.change_state("Hurt")

func is_dead() -> bool:
	return current_health <= 0

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body == player:
		state_machine.change_state("Chase")

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == player:
		state_machine.change_state("Idle")

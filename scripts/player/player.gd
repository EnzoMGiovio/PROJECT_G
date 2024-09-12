# Player.gd
extends CharacterBody2D

@export var bullet_scene = preload("res://scenes/weapons/bullets/bullet.tscn")
@export var movement_speed: float = 200.0
@export var rotation_speed: float = 10.0
@export var capture_mouse: bool = true
@export var max_health = 100  # Salud máxima del jugador

var current_health  # Salud actual del jugador
var damage_cooldown = false
var current_state: State
var look_direction: Vector2 = Vector2.RIGHT
var screen_size: Vector2
var interactable_object: Node = null

@onready var state_machine = $PlayerStateMachine
@onready var hitbox: Area2D = $Hitbox
@onready var interaction_area: Area2D = $InteractionArea

func _ready() -> void:
	
	current_health = max_health
	screen_size = get_viewport_rect().size
	set_mouse_capture(capture_mouse)
	state_machine.initialize()
	interaction_area.connect("area_entered", Callable(self, "_on_interaction_area_entered"))
	interaction_area.connect("area_exited", Callable(self, "_on_interaction_area_exited"))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):  # Usualmente la tecla Esc
		set_mouse_capture(!capture_mouse)
	state_machine.handle_input(event)
	
	if event.is_action_pressed("interact"):
		if interactable_object:
			state_machine.change_state("Interact")
		else:
			print("No hay nada con lo que interactuar aqui.")
	
func _process(delta: float) -> void:
	state_machine.update(delta)

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)

func handle_movement() -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_vector * movement_speed
	move_and_slide()

func handle_rotation(delta: float) -> void:
	var target_direction: Vector2 = get_global_mouse_position() - global_position
	look_direction = look_direction.lerp(target_direction.normalized(), rotation_speed * delta)
	rotation = look_direction.angle()

func shoot_bullet() -> void:
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.shoot(look_direction)

func set_mouse_capture(should_capture: bool) -> void:
	capture_mouse = should_capture
	if capture_mouse:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		

func take_damage(amount):
	# Función para reducir la salud del jugador
	current_health -= amount
	print("Salud actual: ", current_health)  # Para depuración
	
	# Comprobamos si el jugador se ha quedado sin salud
	if current_health <= 0:
		die()

func die():
	# Función llamada cuando el jugador se queda sin salud
	print("El jugador ha muerto")  # Para depuración
	# Reiniciamos la escena actual
	get_tree().call_deferred("reload_current_scene")

func _on_hitbox_area_entered(area):
	# Esta función se llamará cuando un área entre en contacto con el HurtBox del jugador
	if not damage_cooldown:
		take_damage(10)  # Puedes ajustar la cantidad de daño
		damage_cooldown = true
		# Iniciamos un temporizador para reiniciar el cooldown
		$DamageCooldownTimer.start()


func _on_interaction_area_entered(area: Area2D) -> void:
	if area.is_in_group("interactable"):
		interactable_object = area.get_parent()
		print("Tocaste un obj")

func _on_interaction_area_exited(area: Area2D) -> void:
	if area.get_parent() == interactable_object:
		interactable_object = null
		print("Dejaste de tocar un obj")
	else:
		print("Saliste de un área, pero no era el objeto interactuable actual")


func _on_damage_cooldown_timer_timeout() -> void:
	damage_cooldown = false

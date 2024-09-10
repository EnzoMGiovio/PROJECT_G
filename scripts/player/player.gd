# Player.gd
extends CharacterBody2D

@export var bullet_scene = preload("res://scenes/weapons/bullets/bullet.tscn")
@export var movement_speed: float = 200.0
@export var rotation_speed: float = 10.0
@export var capture_mouse: bool = true

var current_state: State
var look_direction: Vector2 = Vector2.RIGHT
var screen_size: Vector2

@onready var state_machine = $PlayerStateMachine

func _ready() -> void:
	screen_size = get_viewport_rect().size
	set_mouse_capture(capture_mouse)
	state_machine.initialize()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):  # Usualmente la tecla Esc
		set_mouse_capture(!capture_mouse)
	state_machine.handle_input(event)

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

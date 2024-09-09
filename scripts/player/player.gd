extends CharacterBody2D



@export var bullet_scene = preload("res://scenes/weapons/bullets/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get the global mouse position
	var mouse_pos = get_global_mouse_position()

	# Calculate the direction from the sprite to the mouse
	var camera_direction = mouse_pos - global_position

	# Use atan2 to get the angle between the direction vector and the x-axis
	var angle = camera_direction.angle()
	# Apply the angle to the sprite's rotation
	rotation = angle
	
	if Input.is_action_just_pressed("shoot"):
		shoot_bullet()
	
func _physics_process(delta): 

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down") 
	velocity = direction * 200

	move_and_slide()
	
func shoot_bullet():
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
		
	# Calcular la dirección en la que se está mirando
	var direction_vector = Vector2.RIGHT.rotated(rotation)
		
		# Llamar a la función shoot de la bala
	bullet.shoot(direction_vector)

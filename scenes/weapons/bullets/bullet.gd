extends Area2D

# Variables para configurar la bala
var speed = 800
var direction = Vector2.ZERO
var is_active = false

# Duración máxima de vida de la bala (en segundos)
@export var bullet_lifetime = 0.5  # Puedes ajustar el tiempo de vida de la bala aquí

func _ready():
	# Configurar el tamaño de la pantalla
	is_active = false
	hide()
	$CollisionShape2D.set_deferred("disabled", true)

# Función que activa la bala y le da dirección
func shoot(direction_vector):
	direction = direction_vector.normalized()
	is_active = true
	position = get_parent().get_node("Player").position  # Empieza desde el player
	show()  # Mostrar la bala cuando se dispara
	$CollisionShape2D.set_deferred("disabled", false)
	
	# Iniciar el temporizador para el tiempo de vida de la bala
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = bullet_lifetime
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_disappear"))  # Usar Callable en lugar del método antiguo
	timer.start()

func _process(delta):
	if is_active:
		# Mover la bala en la dirección establecida
		position += direction * speed * delta

		# Si la bala sale de los bordes de la pantalla, desaparece

# Función para desaparecer la bala cuando entra en contacto con un área
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		_disappear()

# Función para hacer que la bala desaparezca
func _disappear():
	hide()
	is_active = false
	$CollisionShape2D.set_deferred("disabled", false)
	queue_free()  # Eliminar la bala una vez ha desaparecido

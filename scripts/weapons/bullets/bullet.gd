extends Area2D

# Variables para configurar la bala
var speed = 800
var direction = Vector2.ZERO
var is_active = false

# Referencia a los bordes de la pantalla
var screen_size

func _ready():
	# Configurar el tamaño de la pantalla
	screen_size = get_viewport_rect().size
	hide() # Ocultar la bala por defecto

# Función que activa la bala y le da dirección
func shoot(direction_vector):
	direction = direction_vector.normalized()
	is_active = true
	position = get_parent().get_node("Player").position # Empieza desde el player
	show() # Mostrar la bala cuando se dispara

func _process(delta):
	if is_active:
		# Mover la bala en la dirección establecida
		position += direction * speed * delta
		
		# Si la bala sale de la pantalla, desaparece
		if position.x < 0 or position.y < 0 or position.x > screen_size.x or position.y > screen_size.y:
			_disappear()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		queue_free()

# Función para desaparecer la bala
func _disappear():
	hide()
	is_active = false
	queue_free() # Eliminar la bala una vez ha desaparecido

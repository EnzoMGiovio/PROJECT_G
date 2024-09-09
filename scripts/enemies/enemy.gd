extends CharacterBody2D

# Reference to the Player node
var player: Node2D

# Movement speed of the enemy
@export var speed = 100
@export var enemy_health: int = 5

func _ready():
	# Find the Player node in the scene tree
	player = get_node_or_null("/root/World/Player")

func _physics_process(delta):
	# Check if the Player node was found
	if player:
		# Calculate the direction towards the player
		var direction = (player.global_position - global_position).normalized()
		
		# Move the enemy towards the player
		velocity = direction * speed
		move_and_slide()
	else:
		# If the Player node wasn't found, stop the enemy
		velocity = Vector2.ZERO
		move_and_slide()

func enemy_death():

	if enemy_health == 0:
		queue_free()
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		enemy_health -= 1
		print("Enemy health: ", enemy_health)
		enemy_death()
	

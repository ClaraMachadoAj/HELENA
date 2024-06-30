extends CharacterBody2D

const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Movimentação horizontal
	var direction_x = Input.get_axis("LEFT", "RIGHT")
	if direction_x != 0:
		velocity.x = direction_x * SPEED
		velocity.y = 0  # Zerar a velocidade vertical se movendo horizontalmente
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# Movimentação vertical
		var direction_y = Input.get_axis("UP", "DOWN")
		if direction_y != 0:
			velocity.y = direction_y * SPEED
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

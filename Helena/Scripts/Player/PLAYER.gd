extends CharacterBody2D
class_name PLAYER

#Movimentação
const SPEED = 300.0
const SPRINT_MULTIPLIER = 1.5
const MAX_STAMINA = 3.0  # Estamina máxima em segundos

var last_direction = 0.0

#Sanidade
signal  sanidadeChanged
@export var maxSanidade = 100
@onready var currentSanidade: int = maxSanidade


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#ANIMAÇÃO
@onready var anim = get_node("AnimatedSprite2D")


#SANITYTIMER - sanidade
@onready var sanity_timer = $SanityTimer  

var stamina = MAX_STAMINA
var can_sprint = true

func _ready():
	#Sanidade
	sanity_timer.connect("timeout", Callable(self, "_on_SanityTimer_timeout"))
	sanity_timer.start()
	
	set_physics_process(true)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Check if the sprint key is pressed
	if Input.is_action_pressed("SPRINT") and can_sprint and stamina > 0:
		stamina -= delta
		if stamina <= 0:
			stamina = 0
			can_sprint = false
	else:
		# Reset stamina when sprint key is released
		if not Input.is_action_pressed("SPRINT"):
			reset_stamina()

	# Adjust speed based on sprinting
	var current_speed = SPEED
	if can_sprint and Input.is_action_pressed("SPRINT"):
		current_speed *= SPRINT_MULTIPLIER

	# Movimentação horizontal
	var direction_x = Input.get_axis("LEFT", "RIGHT")
	if direction_x != 0:
		velocity.x = direction_x * current_speed
		velocity.y = 0 
		if direction_x > 0:
			anim.play("Right")
			last_direction = 1
		else:
			anim.play("Left")
			last_direction = 2
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if last_direction == 2:
			anim.play("Idle_Left")
		if last_direction == 1:
			anim.play("Idle_Right")
		
		# Movimentação vertical
		var direction_y = Input.get_axis("UP", "DOWN")
		if direction_y != 0:
			velocity.y = direction_y * current_speed
			if direction_y > 0:
				anim.play("Down")
				last_direction = 1
			else:
				anim.play("Up")
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
			anim.play("Idle_down")
		if Input.is_action_pressed("acalmar"):
			anim.play("Acalmar")

	move_and_slide()

func reset_stamina():
	stamina = MAX_STAMINA
	can_sprint = true
	

#Sanidade
func _on_SanityTimer_timeout():
	testSanidade()

func testSanidade():
	currentSanidade -= 1
	if Global.sanity_interaction == 1:
		currentSanidade -= 20
		Global.sanity_interaction = 0
	if currentSanidade < 10:
		currentSanidade = maxSanidade
	sanidadeChanged.emit()
	if Input.is_action_pressed("acalmar"):
		currentSanidade +=5
	

extends CharacterBody2D

@export var speed = 400
var screen_size
const SPEED = 120.0
const JUMP_VELOCITY = -290.0
const DEATH = -180.0
var deathBool = false
	
func die():
	velocity.y = DEATH
	deathBool = true
	#death_sound.play()
	#shape.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(game_delta: float) -> void:
	if deathBool == true:
		print("dead")
		#sprite.play("death")

func _physics_process(game_delta):
	# Add the gravity.
	var velocity = Vector2.ZERO
	if not is_on_floor():
		velocity.y += get_gravity * game_delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY
		
	#Handle Crouch
	if Input.is_action_just_pressed("crouch") and is_on_floor():
		pass
		#implement crouch code

	# Get the input direction.
	if Input.is_action_pressed("move_left"):
		velocity.x += speed * game_delta
	if Input.is_action_pressed("move_right"):
		velocity.x -= speed * game_delta

	move_and_slide()

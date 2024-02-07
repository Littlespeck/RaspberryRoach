extends CharacterBody2D


const SPEED = 300.0
@export var JUMP_VELOCITY = -650.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumping = false
var face_right = true

#Coyote Time Variables
#player walks off the edge of a platform we still allow them to jump as if they were still on the ground for a few frames
var coyote_frames = 5  # How many in-air frames to allow jumping
var coyote = false  # Track whether we're in coyote time or not
var last_floor = false  # Last frame's on-floor state

var jump_buffer : float = 0.0

func _ready():
	$CoyoteTimer.wait_time = coyote_frames / 60.0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if velocity.y >= 0:
			velocity.y += gravity * delta * 2
		else:
			velocity.y += gravity * delta
		
		if jump_buffer > 0: #if jump buffer is still active, count down the realtime between frames.
			jump_buffer -= delta


	if !is_on_floor() and last_floor and !jumping:
		coyote = true
		$CoyoteTimer.start()

	# Handle jump.
	if (Input.is_action_just_pressed("Jump") or jump_buffer > 0) and is_on_floor() and !jumping:
		velocity.y = JUMP_VELOCITY
		jump_buffer = 0.0 #if the player can jump, reset the jump buffer to 0.
		jumping = true
		$CoyoteTimer.start()
	if Input.is_action_just_pressed("Jump") and $CoyoteTimer.time_left >= 0 and !jumping:
		velocity.y = JUMP_VELOCITY
		jumping = true
		$CoyoteTimer.stop()
	
	if Input.is_action_just_pressed("Jump") and !is_on_floor(): #if player is in the air and hitting the jump button, set jump buffer timer.
		jump_buffer = 0.18

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("Move_Left", "Move_Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	last_floor = is_on_floor()
	
	##
	##Animations
	##
	
	if jumping:
		get_node("AnimationPlayer").play("jump")
		
	if velocity.x == 0 and !jumping:
		get_node("AnimationPlayer").play("idle")
	
	if velocity.x != 0 and !jumping:
		get_node("AnimationPlayer").play("walk")
	

	
	if velocity.y == 0:
		jumping = false
	
	if velocity.x > 0 and face_right == false:
		scale.x = -.2
		face_right = true
	
	if velocity.x < 0 and face_right == true:
		scale.x = -.2
		face_right = false


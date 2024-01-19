extends CharacterBody2D

signal PlatformErased

const SPEED = 300.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jumping = false

#Coyote Time Variables
#player walks off the edge of a platform we still allow them to jump as if they were still on the ground for a few frames
var coyote_frames = 6  # How many in-air frames to allow jumping
var coyote = false  # Track whether we're in coyote time or not
var last_floor = false  # Last frame's on-floor state

func _ready():
	$CoyoteTimer.wait_time = coyote_frames / 60.0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if !is_on_floor() and last_floor and !jumping:
		coyote = true
		$CoyoteTimer.start()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or coyote):
		velocity.y = JUMP_VELOCITY
		jumping = true

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	last_floor = is_on_floor()

func _on_coyote_timer_timeout():
	coyote = false

func _on_platform_kill_zone_body_entered(body):
	if body.is_in_group("Platform"):
		print("Platform Erased")
		body.queue_free()
		PlatformErased.emit()

extends CharacterBody2D

@export var gravity = 200.0
@export var walk_speed = 200
@export var jump_speed = -300
@export var stomp_speed = 500
@export var bounce_multiplier = 1.5

var is_stomping = false
var stomp_bounce = false
var controllable = true

@onready var sprite = $AnimatedSprite2D
@onready var sfx = {
	"Jump": $SFX/Jump,
	"Scream": $SFX/Scream,
	"Stomp": $SFX/Stomp,
	"Bounce": $SFX/StompBounce,
	"Slam": $SFX/Slam,
	"Win": $SFX/Win
}


func _physics_process(delta: float) -> void:
	velocity.y += delta * gravity
	if controllable:
		_handle_input()
	move_and_slide()


func _handle_input():
	# Landing an air stomp
	if is_on_floor() and is_stomping:
		is_stomping = false
		sfx.Slam.play()

		# Start stomp bounce period
		stomp_bounce = true
		$StompEndTimer.start()

	if Input.is_action_just_pressed("jump"):
		# Stomp bounce
		if stomp_bounce:
			velocity.y = jump_speed * bounce_multiplier
			stomp_bounce = false
			sfx.Bounce.play()
		# Regular jump
		elif is_on_floor():
			velocity.y = jump_speed
			sfx.Jump.play()

	# Starting an air stomp
	if not is_on_floor() and Input.is_action_just_pressed("stomp"):
		is_stomping = true
		velocity.y = stomp_speed
		sfx.Stomp.play()

	# Horizontal movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * walk_speed
		# Sprite direction
		if direction > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed)

	# Determine animation
	var animation = "Idle"
	if is_stomping:
		animation = "Stomp"
	elif not is_on_floor():
		animation = "Mid-air"
	elif direction:
		animation = "Walk"

	# Play animation
	if sprite.animation != animation:
		sprite.play(animation)


func _on_stomp_end_timer_timeout() -> void:
	# End stomp bounce period
	stomp_bounce = false


func _disable_movement() -> void:
	controllable = false
	velocity = Vector2(0, 0)


func kill() -> void:
	# Kill player
	_disable_movement()
	sfx.Scream.play()
	sprite.play("Die")


func win() -> void:
	# Player wins
	_disable_movement()
	sfx.Win.play()
	sprite.play("Win")

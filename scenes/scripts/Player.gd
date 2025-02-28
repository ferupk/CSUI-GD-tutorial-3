extends CharacterBody2D

@export var gravity = 200.0
@export var walk_speed = 200
@export var jump_speed = -300
@export var stomp_speed = 500
@export var bounce_multiplier = 1.5
var is_stomping = false
var stomp_bounce = false

@onready var sprite = $AnimatedSprite2D


func _physics_process(delta):
	velocity.y += delta * gravity

	if is_on_floor() and is_stomping:
		print("Stomp end, bounce window open")
		is_stomping = false
		stomp_bounce = true
		$StompEndTimer.start()

	if Input.is_action_just_pressed("ui_up"):
		if stomp_bounce:
			velocity.y = jump_speed * bounce_multiplier
			stomp_bounce = false
			print("Bounce used")
		elif is_on_floor():
			velocity.y = jump_speed

	if not is_on_floor() and Input.is_action_just_pressed("ui_down"):
		print("Stomp start")
		is_stomping = true
		velocity.y = stomp_speed

	if Input.is_action_pressed("ui_left"):
		velocity.x = -walk_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = walk_speed
	else:
		velocity.x = 0

	determine_sprite()

	# "move_and_slide" already takes delta time into account.
	move_and_slide()


func determine_sprite():
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true

	if is_stomping:
		sprite.play("Stomp")
	elif not is_on_floor():
		sprite.play("Mid-air")
	elif velocity.x:
		sprite.play("Walk")
	else:
		sprite.play("Idle")


func _on_stomp_end_timer_timeout() -> void:
	stomp_bounce = false
	print("Bounce Window Closed")

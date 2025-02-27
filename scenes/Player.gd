extends CharacterBody2D

@export var gravity = 200.0
@export var walk_speed = 200
@export var jump_speed = -300
@export var stomp_speed = 500
var isStomping = false
var stompBounce = false

func _physics_process(delta):
	velocity.y += delta * gravity
	
	if is_on_floor(): 
		if isStomping:
			print("Stomp end, bounce window open")
			isStomping = false
			stompBounce = true
			$StompEndTimer.start()
		if Input.is_action_just_pressed('ui_up'):
			if stompBounce:
				velocity.y = jump_speed * 1.5
				stompBounce = false
				print("Bounce used")
			else:
				velocity.y = jump_speed
	
	if not is_on_floor() and Input.is_action_just_pressed('ui_down'):
		print("Stomp start")
		isStomping = true
		velocity.y = stomp_speed
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -walk_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  walk_speed
	else:
		velocity.x = 0

	# "move_and_slide" already takes delta time into account.
	move_and_slide()


func _on_stomp_end_timer_timeout() -> void:
	stompBounce = false
	print("Bounce Window Closed")

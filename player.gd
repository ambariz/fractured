extends CharacterBody2D

@export var speed := 250.0
@export var jump_force := 450.0
@export var gravity := 1200.0
@export var deceleration := 1500.0

var was_on_floor := false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction := Input.get_axis("move_left", "move_right")

	if direction != 0:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

	move_and_slide()
	
	if is_on_floor() and not was_on_floor:
		AudioManager.play_sfx(("jump"))

	was_on_floor = is_on_floor()

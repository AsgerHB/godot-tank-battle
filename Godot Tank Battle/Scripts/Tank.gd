extends KinematicBody2D

export var speed = 200
export var rot_speed = 0.085
var velocity = Vector2()

export(bool) var is_player2

func get_input():
	velocity = Vector2()

	if Input.is_action_pressed("ui_left"):
		rotation -= rot_speed
	if Input.is_action_pressed("ui_right"):
		rotation += rot_speed

	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(-speed / 2, 0).rotated(rotation)
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(speed, 0).rotated(rotation)

func get_input2():
	velocity = Vector2()

	if Input.is_action_pressed("left2"):
		rotation -= rot_speed
	if Input.is_action_pressed("right2"):
		rotation += rot_speed

	if Input.is_action_pressed("up2"):
		velocity = Vector2(-speed / 2, 0).rotated(rotation)
	if Input.is_action_pressed("down2"):
		velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	if is_player2:
		get_input2()
	else:
		get_input()
	
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)
	velocity = Vector2.ZERO

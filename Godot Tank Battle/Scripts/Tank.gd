extends KinematicBody2D

export(float) var speed = 200
export(float) var rot_speed = 0.0375
export(bool) var is_player2
export(PackedScene) var tracks
export(float) var track_interval = 3
export(NodePath) var world_path

var velocity: Vector2 = Vector2()

var last_track_pos: Vector2

var is_dead = false

const restart_time: float = 2.0
var restart_timer: float = 0.0

var shake_timer: float = 0

onready var world = get_node(world_path)

var turning_pitch = 0.5
var driving_pitch = 1

var turned = false
var drove = false

var should_pitch_again = true

func bullet_hit():
	is_dead = true
	$Wreck.visible = true
	$Vehicle.visible = false
	$CollisionShape2D.disabled = true

	$Explosion.start()

	if not is_player2:
		Global.player1_score += 1
	else:
		Global.player2_score += 1

	$DieSound.play()

func _ready():
	$ShootyPoint.is_player2 = is_player2
	$ShootyPoint.world = world
	last_track_pos = self.get_global_position()
	
	var color: Color
	if is_player2:
		color = Color(0.5, 1, 0.5)
	else:
		color = Color(1, 0.5, 0.5)
	
	$Vehicle/color_mask.modulate = color

func get_input():
	velocity = Vector2()

	if Input.is_action_pressed("ui_left"):
		turned = true
		rotation -= rot_speed
	if Input.is_action_pressed("ui_right"):
		turned = true
		rotation += rot_speed

	if Input.is_action_pressed("ui_up"):
		drove = true
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("ui_down"):
		drove = true
		velocity = Vector2(speed / 1.5, 0).rotated(rotation)

func get_input2():
	velocity = Vector2()

	if Input.is_action_pressed("left2"):
		self.turned = true
		rotation -= rot_speed
	if Input.is_action_pressed("right2"):
		self.turned = true
		rotation += rot_speed

	if Input.is_action_pressed("up2"):
		self.drove = true
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("down2"):
		self.drove = true
		velocity = Vector2(speed / 1.5, 0).rotated(rotation)


func draw_tracks():
	var current_pos = self.get_global_position()
	
	if last_track_pos.distance_to(current_pos) > track_interval:
		last_track_pos = current_pos
		var t = tracks.instance()
		t.position = current_pos
		t.rotation = self.rotation
		get_tree().get_root().get_child(1).add_child(t)

func _physics_process(delta):
	if is_dead:
		restart_timer += delta

		if restart_timer >= restart_time:
			Global.new_round()

		return

	turned = false
	drove = false

	if is_player2:
		get_input2()
	else:
		get_input()

	if turned and not drove:
		if not $Driving.playing:
			$Driving.play()

		$Driving.pitch_scale = turning_pitch
	
	if self.drove:
		if not $Driving.playing:
			$Driving.play()

		if self.should_pitch_again:
			$Driving.pitch_scale = driving_pitch + rand_range(-0.15, 0.15)
			self.should_pitch_again = false
	else:
		self.should_pitch_again = true

	if not drove and not turned:
		$Driving.stop()

	velocity = move_and_slide(velocity)
	velocity = Vector2.ZERO
	
	draw_tracks()

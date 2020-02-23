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

func bullet_hit():
	is_dead = true
	$Wreck.visible = true
	$Vehicle.visible = false
	$CollisionShape2D.disabled = true

	$Explosion.start()

	if is_player2:
		Global.player1_score += 1
	else:
		Global.player2_score += 1

func _ready():
	$ShootyPoint.is_player2 = is_player2
	$ShootyPoint.world = world
	last_track_pos = self.get_global_position()
	
	if is_player2:
		self.modulate = Color(0.5, 1, 0.5)
	else:
		self.modulate = Color(1, 0.5, 0.5)

func get_input():
	velocity = Vector2()

	if Input.is_action_pressed("ui_left"):
		rotation -= rot_speed
	if Input.is_action_pressed("ui_right"):
		rotation += rot_speed

	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(speed / 1.5, 0).rotated(rotation)

func get_input2():
	velocity = Vector2()

	if Input.is_action_pressed("left2"):
		rotation -= rot_speed
	if Input.is_action_pressed("right2"):
		rotation += rot_speed

	if Input.is_action_pressed("up2"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("down2"):
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
	
	if is_player2:
		get_input2()
	else:
		get_input()
	
	velocity = move_and_slide(velocity)
	velocity = Vector2.ZERO
	
	draw_tracks()

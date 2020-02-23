extends Node2D

export(bool) var is_player2
export(float) var spawn_distance
export(float) var bullet_lifetime = 3
export(int) var max_active_bullets = 4
export(float) var shoot_delay = 0.4

export(PackedScene) var Bullet

var world: Node2D

var active_bullets: int = 0

var shoot_timer: float = 0
var waiting_to_shoot = false

func handle_input(delta: float):
	shoot_timer -= delta
	
	if (is_player2 and Input.is_action_just_pressed("shoot")) \
	or (!is_player2 and  Input.is_action_just_pressed("shoot2")):
		waiting_to_shoot = true
	
	if shoot_timer > 0:
		return
	
	if waiting_to_shoot:
		shoot()
		waiting_to_shoot = false
		shoot_timer = shoot_delay

func shoot():
	if active_bullets >= max_active_bullets:
		return
	
	active_bullets += 1
	var b = Bullet.instance()
	var spawn_rotation = get_parent().rotation + PI
	var spawn_direction_vector = Vector2(1, 0).rotated(spawn_rotation)

	var spawn_position = get_global_position() + spawn_direction_vector * spawn_distance

	b.start(spawn_position, spawn_rotation)
	b.lifetime = bullet_lifetime
	
	world.add_child(b)
	b.shooter = self
	
	$ShootSound.playing = true

func register_bullet_freed():
	active_bullets -= 1

func _process(delta):
	handle_input(delta)

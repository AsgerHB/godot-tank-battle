extends Node2D

export(bool) var is_player2
export(float) var spawn_distance
export(float) var bullet_lifetime = 3
export(int) var max_active_bullets = 4
export(PackedScene) var Bullet

var active_bullets: int = 0

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
	
	get_tree().get_root().add_child(b)
	b.shooter = self

func register_bullet_freed():
	active_bullets -= 1

func _process(delta):
	if is_player2:
		if Input.is_action_just_pressed("shoot"):
			shoot()
	else:
		if Input.is_action_just_pressed("shoot2"):
			shoot()

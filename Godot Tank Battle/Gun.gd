extends Node2D

export(bool) var is_player2
export(float) var spawn_distance
export(float) var bullet_lifetime = 3
export(PackedScene) var Bullet

func shoot():
	var b = Bullet.instance()
	var spawn_rotation = get_parent().rotation + PI
	var spawn_direction_vector = Vector2(1, 0).rotated(spawn_rotation)
	var spawn_position = self.get_global_position() + spawn_direction_vector * spawn_distance
	b.start(spawn_position, spawn_rotation)
	b.lifetime = bullet_lifetime
	get_parent().get_parent().add_child(b)

func _process(delta):
	if is_player2:
		if Input.is_action_just_pressed("shoot"):
			shoot()
	else:
		if Input.is_action_just_pressed("shoot2"):
			shoot()

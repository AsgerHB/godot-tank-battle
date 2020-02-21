extends Node2D

export(bool) var is_player2
export(PackedScene) var Bullet

func shoot():
	var b = Bullet.instance()
	b.start(self.position, rotation)
	get_parent().add_child(b)

func _process(delta):
	if is_player2:
		if Input.is_action_just_pressed("shoot"):
			shoot()
	else:
		if Input.is_action_just_pressed("shoot2"):
			shoot()

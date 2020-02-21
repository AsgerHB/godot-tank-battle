extends Node2D

export(bool) var is_player2
export(PackedScene) var Bullet

func shoot():
	var b = Bullet.instance()
	b.start(self.get_global_position(), get_parent().rotation + PI)
	get_parent().get_parent().add_child(b)

func _process(delta):
	if is_player2:
		if Input.is_action_just_pressed("shoot"):
			shoot()
	else:
		if Input.is_action_just_pressed("shoot2"):
			shoot()

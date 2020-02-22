extends Sprite

var opacity = 0.38

func _process(delta):
	opacity -= delta / 20
	self.modulate = Color(0.15, 0.15, 0.15, opacity)
	
	if opacity <= 0:
		queue_free()

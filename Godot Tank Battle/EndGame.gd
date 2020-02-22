extends Node2D

export(float) var radius = 80

var angle = 0

func _ready():
	self.position = Vector2.ZERO

func _process(delta):
	var parent_pos = get_parent().get_global_position()
	
	angle += delta * 2
	
	self.rotation = get_parent().rotation - get_global_rotation() 

	self.position = Vector2(
		radius * cos(angle),
		radius * sin(angle)
	)

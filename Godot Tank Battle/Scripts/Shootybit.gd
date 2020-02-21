extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input();


func get_input():
	if Input.is_action_just_released('ui_select'):
		print ('fof');

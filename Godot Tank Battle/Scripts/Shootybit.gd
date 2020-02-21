extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass; # Replace with function body.


func _physics_process(delta):
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input();


func get_input():
	if Input.is_action_just_released('ui_select'):
		print ('fof');

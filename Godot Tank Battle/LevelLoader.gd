extends Node2D

export(Array, PackedScene) var scenes

func _ready():
	randomize()
	add_child(scenes[randi() % (len(scenes) - 1)].instance())

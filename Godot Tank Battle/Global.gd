extends Node

var player1_score: int = 0
var player2_score: int = 0

func new_round():
	get_tree().reload_current_scene()

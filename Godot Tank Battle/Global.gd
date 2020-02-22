extends Node

var player1_score: int = 0
var player2_score: int = 0

func new_round(is_player2):
	if is_player2:
		player2_score += 1
	else:
		player1_score += 1

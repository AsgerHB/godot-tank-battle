extends Node2D

var current_zoom: float = 1

func _process(delta):
	var player1_pos = $Player.position
	var player2_pos = $Player2.position

	$Camera2D.set_position(
		Vector2(
			(player1_pos.x + player2_pos.x) / 2,
			(player1_pos.y + player2_pos.y) / 2
		)
	)
	
	var target_zoom = clamp(abs(player1_pos.x - player2_pos.x) / 300, 1, 1.75)
	current_zoom = lerp(current_zoom, target_zoom, delta * 5)
	
	$Camera2D.set_zoom(
		Vector2(
			current_zoom,
			current_zoom
		)
	)

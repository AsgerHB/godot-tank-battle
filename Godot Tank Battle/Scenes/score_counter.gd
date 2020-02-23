extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var player1_score
export(NodePath) var player2_score

# Called when the node enters the scene tree for the first time.
func _ready():
	var globals = get_tree().get_root().get_child(0)
	
	get_node(player1_score).text = str(globals.player1_score)
	get_node(player2_score).text = str(globals.player2_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var player1_score
export(NodePath) var player2_score

var player1_counter
var player2_counter

# Called when the node enters the scene tree for the first time.
func _ready():
	player1_counter = get_node(player1_score)
	player2_counter = get_node(player2_score)
	
	player1_counter.text = str(Global.player1_score)
	player2_counter.text = str(Global.player2_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player1_counter.text = str(Global.player1_score)
	player2_counter.text = str(Global.player2_score)

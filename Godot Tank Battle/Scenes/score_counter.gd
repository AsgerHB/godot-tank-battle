extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var player1_counter_path
export(NodePath) var player2_counter_path


export(NodePath) var player1_gets_point_particles_path
export(NodePath) var player2_gets_point_particles_path



var player1_counter: Control
var player2_counter: Control
var player1_gets_point_particles: Node2D
var player2_gets_point_particles: Node2D

var player1_score_previous = Global.player1_score
var player2_score_previous = Global.player2_score

func redraw_score():
	player1_counter.text = str(Global.player1_score)
	player2_counter.text = str(Global.player2_score)
	
	if player1_score_previous < Global.player1_score:
		player1_gets_point_particles.start()
	if player2_score_previous < Global.player2_score:
		player2_gets_point_particles.start()
	
	player1_score_previous = Global.player1_score
	player2_score_previous = Global.player2_score
	

# Called when the node enters the scene tree for the first time.
func _ready():
	player1_counter = get_node(player1_counter_path)
	player2_counter = get_node(player2_counter_path)
	
	player1_gets_point_particles = get_node(player1_gets_point_particles_path)
	player2_gets_point_particles = get_node(player2_gets_point_particles_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	redraw_score()
	

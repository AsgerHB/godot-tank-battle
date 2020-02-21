extends KinematicBody2D


# Declare member variables here. Examples:
export var a:float = 1;
export var b: float = 2;
var velocity: Vector2;

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(a, b);


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	move_and_collide(velocity * delta);

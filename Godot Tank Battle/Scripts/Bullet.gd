extends KinematicBody2D


# Declare member variables here. Examples:
export var dir_x: float = 1;
export var dir_y: float = 2;
export var speed: float = 100;
var velocity: Vector2;

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(dir_x, dir_x).normalized() * speed;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta);
	if collision:
		velocity = collision.normal * speed;

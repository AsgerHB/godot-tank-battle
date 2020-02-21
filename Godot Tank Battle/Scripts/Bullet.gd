extends KinematicBody2D

# Declare member variables here. Examples:

export var speed: float = 100
var velocity: Vector2

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("bullet_hit"):
			collision.collider.bullet_hit()

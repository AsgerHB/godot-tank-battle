extends KinematicBody2D

# Declare member variables here. Examples:

export(float) var speed = 100
export(float) var lifetime = 1
export(Resource) var shooter = null

var age: float = 0
var velocity: Vector2

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	age += delta
	if(age > lifetime):
		self.queue_free()
		if shooter && shooter.has_method("register_bullet_freed"):
			shooter.register_bullet_freed()
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("bullet_hit"):
			collision.collider.bullet_hit()

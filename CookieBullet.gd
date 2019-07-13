extends KinematicBody2D

export var BulletSpeed = 500

var direction = Vector2()

func _physics_process(delta):
	move_and_collide(direction * BulletSpeed * delta)

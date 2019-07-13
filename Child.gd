extends KinematicBody2D

export var Speed = 300

func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		position.x += Speed * delta
	elif Input.is_action_pressed("move_left"):
		position.x -= Speed * delta
	
	if Input.is_action_pressed("move_up"):
		position.y -= Speed * delta
	elif Input.is_action_pressed("move_down"):
		position.y += Speed * delta

func _input(event):
	if event.is_action_pressed("shoot"):
		var shoot_direction = (event.position - position).normalized()
		shoot(shoot_direction)

func shoot(direction):
	var bullet_scene = load("res://CookieBullet.tscn")
	var bullet = bullet_scene.instance()
	bullet.position = position
	bullet.direction = direction
	get_owner().add_child(bullet)
extends KinematicBody2D

export var Speed = 300
var type = "child"

func _physics_process(delta):
	var deltaPos = Vector2()
	if Input.is_action_pressed("move_right"):
		deltaPos.x += Speed
	elif Input.is_action_pressed("move_left"):
		deltaPos.x -= Speed
	
	if Input.is_action_pressed("move_up"):
		deltaPos.y -= Speed
	elif Input.is_action_pressed("move_down"):
		deltaPos.y += Speed
	
	move_and_slide(deltaPos)

func _input(event):
	if event.is_action_pressed("shoot"):
		var shoot_direction = (event.position - position).normalized()
		shoot(shoot_direction)

func shoot(direction):
	var bullet_scene = load("res://scn/CookieBullet.tscn")
	var bullet = bullet_scene.instance()
	bullet.position = position
	bullet.direction = direction
	get_parent().add_child(bullet)
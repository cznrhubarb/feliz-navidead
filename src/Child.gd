extends KinematicBody2D

export var Speed = 300
var type = "child"

var weapons

func _ready():
	weapons = []
	weapons.push_front(load("res://src/Weapons/CookieGun.gd").new())
	weapons.push_front(load("res://src/Weapons/MilkGrenadeLauncher.gd").new())

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
	
	for weapon in weapons:
		weapon.cooldown(delta)
	if Input.is_action_pressed("shoot"):
		shoot(get_shot_direction(), true)

func _input(event):
	if event.is_action_pressed("shoot"):
		shoot(get_shot_direction(), false)

func get_shot_direction():
	return (get_global_mouse_position() - position).normalized()

func shoot(direction, auto):
	for weapon in weapons:
		var bullet = weapon.shoot(direction, auto)
		if bullet:
			bullet.position = position
			get_parent().add_child(bullet)
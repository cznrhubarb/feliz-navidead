extends KinematicBody2D

export var Speed = 300
var type = "child"

var game_hud
var hp_bar
var health = 100
var weapons
var dialog

func _ready():
	game_hud = get_node("../../GameHud")
	hp_bar = get_node("../../GameHud/HP_Bar")
	dialog = get_tree().get_root().find_node("GiftDialog", true, false)
	print(hp_bar.name)
	randomize()
	weapons = []
	#weapons.push_front(load("res://src/Weapons/MilkGrenadeLauncher.gd").new())

func add_weapon(weapon):
	weapons.push_front(weapon)

func add_curse(curse):
	pass

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
	if not dialog.visible:
		for weapon in weapons:
			var bullet = weapon.shoot(direction, auto)
			if bullet:
				bullet.position = position
				get_parent().add_child(bullet)

func take_damage(value):
	health -= value
	if hp_bar:
		hp_bar.update_health(health)
	else:
		print("no HP bar found")
	if health <= 0:
		queue_free()
		# TODO: VFX
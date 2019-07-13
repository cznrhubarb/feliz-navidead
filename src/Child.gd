extends KinematicBody2D

export var Speed = 300
var type = "child"

var game_hud
var hp_bar
var health = 100
var weapons
var anim_player
var is_moving = false

func _ready():
	game_hud = get_node("../../GameHud")
	hp_bar = get_node("../../GameHud/HP_Bar")
	anim_player = get_node("AnimationPlayer")
	print(hp_bar.name)
	randomize()
	weapons = []
	#weapons.push_front(load("res://src/Weapons/MilkGrenadeLauncher.gd").new())

func add_weapon(weapon):
	weapons.push_front(weapon)

func add_curse(curse):
	pass

func _physics_process(delta):
	is_moving = false
	var deltaPos = Vector2()
	if Input.is_action_pressed("move_right"):
		deltaPos.x += Speed
		is_moving = true
		
	elif Input.is_action_pressed("move_left"):
		deltaPos.x -= Speed
		is_moving = true

	if Input.is_action_pressed("move_up"):
		deltaPos.y -= Speed
		is_moving = true
	elif Input.is_action_pressed("move_down"):
		deltaPos.y += Speed
		is_moving = true
	
	move_and_slide(deltaPos)
	updateAnimation()
	
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

func take_damage(value):
	health -= value
	if hp_bar:
		hp_bar.update_health(health)
	else:
		print("no HP bar found")
	if health <= 0:
		get_tree().paused = true
		print("You have died.")
		# TODO: VFX
		
func updateAnimation():
	if is_moving:
		anim_player.playback_speed = 1
	else:
		anim_player.playback_speed = 0
		
	var direction = get_shot_direction()
	if abs(direction.x) >= abs(direction.y):
		if direction.x >=0:
			anim_player.play("WalkRight")
		else:
			anim_player.play("WalkLeft")
	else:
		if direction.y >=0:
			anim_player.play("WalkDown")
		else:	
			anim_player.play("WalkUp")
	
	
	
	
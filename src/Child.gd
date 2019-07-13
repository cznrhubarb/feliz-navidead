extends KinematicBody2D

export var Speed = 300
var type = "child"

var game_hud
var hp_bar
var health = 100
var weapons
var curses
var anim_player
var is_moving = false
var dialog
var shoot_in_reverse = false
var run_in_reverse = false

func _ready():
	game_hud = get_node("../../GameHud")
	hp_bar = get_node("../../GameHud/HP_Bar")
	anim_player = get_node("AnimationPlayer")
	dialog = get_tree().get_root().find_node("GiftDialog", true, false)
	randomize()
	weapons = []
	curses = []

func add_weapon(weapon):
	weapons.push_front(weapon)

func add_curse(curse):
	curses.push_front(curse)
	if curse.key == "quake":
		find_node("ChildCamera").shake(9999, 30, 5)
	elif curse.key == "gift_horse":
		dialog.find_node("WeaponText").text = "???"
		dialog.find_node("CurseText").text = "???"
	elif curse.key == "reverse_shot":
		shoot_in_reverse = true
	elif curse.key == "reverse_run":
		run_in_reverse = true

func has_curse(curse_name):
	for curse in curses:
		if curse.key == curse_name:
			return true
	return false

func _physics_process(delta):
	is_moving = false
	var delta_pos = Vector2()
	if Input.is_action_pressed("move_right"):
		delta_pos.x += Speed
		is_moving = true
		
	elif Input.is_action_pressed("move_left"):
		delta_pos.x -= Speed
		is_moving = true

	if Input.is_action_pressed("move_up"):
		delta_pos.y -= Speed
		is_moving = true
	elif Input.is_action_pressed("move_down"):
		delta_pos.y += Speed
		is_moving = true
	
	if run_in_reverse:
		delta_pos = Vector2(-delta_pos.x, -delta_pos.y)
	
	move_and_slide(delta_pos)
	updateAnimation()
	
	for weapon in weapons:
		weapon.cooldown(delta)
	if Input.is_action_pressed("shoot"):
		shoot(get_shot_direction(), true)

func _input(event):
	if event.is_action_pressed("shoot"):
		shoot(get_shot_direction(), false)

func get_shot_direction():
	var dir = (get_global_mouse_position() - position).normalized()
	if shoot_in_reverse:
		dir = dir.rotated(3.14159)
	return dir

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

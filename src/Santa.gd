extends KinematicBody2D

export var walk_speed = 50
export var run_speed = 200
export var max_follow_distance = 125

# warning-ignore:unused_class_variable
var type = "enemy"
var player
var hp_bar
var max_health = 1000
var health = max_health
var collision_info
var anim_player
var spr

var time_to_dash
var dash_duration
var dash_direction
var idle_duration = 0

var regular_collision_mask
var regular_collision_layer
var state = "idle"

func _ready():
	player = get_tree().get_root().find_node("Child", true, false)
	hp_bar = get_node("HP_Bar")
	anim_player = find_node("AnimationPlayer", true)
	spr = get_node("Sprite")
	regular_collision_layer = collision_layer
	regular_collision_mask = collision_mask

func _physics_process(delta):
	if state == "idle":
		idle_duration -= delta
		if idle_duration > 0:
			return
	
	if state == "walk":
		time_to_dash -= delta
		if time_to_dash <= 0:
			change_state("charge_up")
	
	if player:
		if state == "dash":
			collision_info = move_and_collide(dash_direction * run_speed * delta)
			if collision_info:
				var collider = collision_info.collider
				if collider.type == "child":
					collider.take_damage(10)
					change_state("attack")
			else:
				dash_duration -= delta
				if dash_duration <= 0:
					change_state("attack")
		elif state != "charge_up" and state != "attack":
			var direction = player.position - position
			if direction.length() < max_follow_distance:
				change_state("walk")
				direction = direction.normalized()
				collision_info = move_and_collide(direction * walk_speed * delta)
				if collision_info:
					var collider = collision_info.collider
					if collider.type == "child":
						collider.take_damage(1)
						
				if direction.x > 0:
					spr.set_flip_h(false)
				elif direction.x < 0:
					spr.set_flip_h(true)

func take_damage(value):
	health -= value
	hp_bar.update_health(health, max_health)
	if health <= 0:
		var game_hud = get_tree().get_root().find_node("GameHud", true, false)
		game_hud.add_score(250)
		queue_free()
		# TODO: VFX

func attack(character):
	if player:
		if collision_info:
			var collider = collision_info.collider
			if collider.type == "child":
				collider.take_damage(10)

func change_state(new_state):
	if new_state == state:
		return
	
	collision_mask = regular_collision_mask
	collision_layer = regular_collision_layer
	state = new_state
	match state:
		"idle":
			anim_player.play("Stand")
		"walk":
			time_to_dash = 3
			anim_player.play("Walk")
		"charge_up":
			anim_player.play("Charge Up")
		"dash":
			collision_layer = 0
			collision_mask = 0
			set_collision_mask_bit(4, true)
			dash_duration = 0.75
			dash_direction = (player.position - position).normalized()
			anim_player.play("Run")
		"attack":
			anim_player.play("SackWhack")
			idle_duration = 1



extends KinematicBody2D

export var walk_speed = 50
export var run_speed = 200
export var max_follow_distance = 300

# warning-ignore:unused_class_variable
var type = "enemy"
var player
var factory
var hp_bar
var max_health = 1000
var health = max_health
var collision_info
var anim_player

var spr
var step_sounds
var step_sound_one_is_next = true
var step_delay = 0

var time_to_dash
var dash_duration
var dash_direction
var idle_duration = 0

var regular_collision_mask
var regular_collision_layer
var state = "idle"

func _ready():
	player = get_tree().get_root().find_node("Child", true, false)
	factory = get_tree().get_root().find_node("GingerFactory", true, false)
	hp_bar = get_node("HP_Bar")
	anim_player = find_node("AnimationPlayer", true)
	spr = get_node("Sprite")
	regular_collision_layer = collision_layer
	regular_collision_mask = collision_mask
	step_sounds = [ get_node("StepOne"), get_node("StepTwo") ]

func _physics_process(delta):
	step_delay -= delta
	if state == "idle":
		idle_duration -= delta
		if idle_duration > 0:
			return
	
	if state == "walk":
		time_to_dash -= delta
		if time_to_dash <= 0:
			change_state("charge_up")
	
	if player:
		var direction = player.position - position
		var step_volume = clamp(direction.length(), 0, 200) / 200 * -80
		
		if state == "dash":
			collision_info = move_and_collide(dash_direction * run_speed * delta)
			if step_delay <= 0:
				step_delay = 0.1
				var snd = step_sounds[(0 if step_sound_one_is_next else 1)]
				step_sound_one_is_next = not step_sound_one_is_next
				snd.volume_db = step_volume /4
				snd.play()
			if collision_info:
				var collider = collision_info.collider
				if collider.type == "child":
					collider.take_damage(10)
					change_state("attack")
				elif collider.type == "tile_map":
					idle_duration = 1.6
					change_state("idle")
			else:
				dash_duration -= delta
				if dash_duration <= 0:
					change_state("attack")
		elif state != "charge_up" and state != "attack":
			if direction.length() < max_follow_distance:
				if step_delay <= 0:
					step_delay = 0.14
					var snd = step_sounds[(0 if step_sound_one_is_next else 1)]
					step_sound_one_is_next = not step_sound_one_is_next
					snd.volume_db = step_volume /1.2
					snd.play()
			
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
		factory.santa_count -= 1
		factory.last_santa = factory.seconds
		explode()
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
			# Turn this back on to make Santa collide with walls
			#set_collision_mask_bit(0, true)
			dash_duration = 0.75
			dash_direction = (player.position - position).normalized()
			anim_player.play("Run")
		"attack":
			anim_player.play("SackWhack")
			idle_duration = 1.6
			
func add_crack():
	var crack = load("res://scn/Crack.tscn").instance()
	crack.position = position
	crack.position.y += 14
	crack.position.x += (-14 if spr.flip_h else 14)
	get_tree().get_root().find_node("TileMap", true, false).add_child(crack)

func play_slam():
	get_node("Slam").play()

func play_hohoho():
	get_node("HoHoHo").play()
	
func explode(location = self.position):
	var explosion_scene = load("res://scn/Explosion.tscn")
	var explosion = explosion_scene.instance()
	explosion.position = location
	explosion.color = Color(1,.5,.5)
	explosion.set_scale(Vector2(3,3))
	get_node("..").add_child(explosion)

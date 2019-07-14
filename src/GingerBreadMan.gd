extends KinematicBody2D

export var Speed = 10
export var max_follow_distance = 150

# warning-ignore:unused_class_variable
var type = "enemy"
var player
var hp_bar
var health
var max_health = 100
var collision_info
var anim_player
var factory
var damage = .1

func _ready():
	player = get_tree().get_root().find_node("Child", true, false)
	factory = get_tree().get_root().find_node("GingerFactory", true, false)
	hp_bar = get_node("HP_Bar")
	health = max_health
	anim_player = get_node("AnimationPlayer")

func _physics_process(delta):
	if player:
		var direction = player.position - position
		if direction.length() < max_follow_distance:
			direction = direction.normalized()
			collision_info = move_and_collide(direction * Speed * delta)
			if collision_info:
				var collider = collision_info.collider
				if collider.type == "child":
					collider.take_damage(damage)
		#Animation
			anim_player.playback_speed = .5
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
		else:
			anim_player.stop()
		
func take_damage(value):
	health -= value
	hp_bar.update_health(health, max_health)
	if health <= 0:
		var game_hud = get_tree().get_root().find_node("GameHud", true, false)
		game_hud.add_score(max_health/2)
		# TODO: Doesn't work because the sound stops when the gbman gets deleted
		#get_node("Groan").play()
		queue_free()
		factory.ginger_count -= 1
		# TODO: VFX
		
		# LOL SO RANDOM 
		if str(max_health)[-1] == "0" || str(max_health)[-1] == "1":
			spawn_pickup(self.position)

		
func attack(character):
	if player:
		if collision_info:
			var collider = collision_info.collider
			if collider.type == "child":
				collider.take_damage(10)
				
func spawn_pickup(location):
	var pickup_scene = load("res://scn/Pickup.tscn")
	var pickup = pickup_scene.instance()
	pickup.position = location
	pickup.life = 20
	get_node("..").add_child(pickup)
	
	
	
	
	
	
extends KinematicBody2D

export var Speed = 10
export var max_follow_distance = 150

# warning-ignore:unused_class_variable
var type = "enemy"
var player
var hp_bar
var health = 100
var collision_info
var anim_player

func _ready():
	player = get_tree().get_root().find_node("Child", true, false)
	hp_bar = get_node("HP_Bar")
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
					collider.take_damage(1)
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
	hp_bar.update_health(health)
	if health <= 0:
		var game_hud = get_tree().get_root().find_node("GameHud", true, false)
		game_hud.add_score(50)
		# TODO: Doesn't work because the sound stops when the gbman gets deleted
		#get_node("Groan").play()
		queue_free()
		# TODO: VFX
		
func attack(character):
	if player:
		if collision_info:
			var collider = collision_info.collider
			if collider.type == "child":
				collider.take_damage(10)
	
extends KinematicBody2D

export var Speed = 10

# warning-ignore:unused_class_variable
var type = "enemy"
var player
var hp_bar
var health = 100
var collision_info

func _ready():
	player = get_tree().get_root().find_node("Child", true, false)
	hp_bar = get_node("HP_Bar")

func _physics_process(delta):
	if player:
		var direction = (player.position - position).normalized()
		collision_info = move_and_collide(direction * Speed * delta)
		if collision_info:
			var collider = collision_info.collider
			if collider.type == "child":
				collider.take_damage(1)
		
func take_damage(value):
	health -= value
	hp_bar.update_health(health)
	if health <= 0:
		queue_free()
		# TODO: VFX
		
func attack(character):
	if player:
		if collision_info:
			var collider = collision_info.collider
			if collider.type == "child":
				collider.take_damage(10)
	
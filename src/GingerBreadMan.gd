extends KinematicBody2D

export var Speed = 10

var type = "enemy"
var player
var health = 100

func _ready():
	player = get_tree().get_root().find_node("Child", true, false)
	print(health)

func _physics_process(delta):
	if player:
		var direction = (player.position - position).normalized()
		move_and_collide(direction * Speed * delta)
		
func _take_damage(value):
	health = health - value
	if health <= 0:
		queue_free()
		# TODO: VFX and kill actor
		pass
extends KinematicBody2D

export var Speed = 10

var type = "enemy"
var player

func _ready():
	player = get_tree().get_root().find_node("Child", true, false)

func _physics_process(delta):
	if player:
		var direction = (player.position - position).normalized()
		move_and_collide(direction * Speed * delta)
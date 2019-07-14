extends KinematicBody2D

func _ready():
	get_node("AgonizingDeathCry").play()
	get_node("Sprite/AnimationPlayer").play("UhOh")

func start_explosion():
	print("Start exploding")
	var explosion = get_node("Explosion")
	explosion.visible = true
	explosion.get_node("AnimationPlayer").play("Explode")

func remove_santa():
	print("Removing santa sprite")
	get_node("Sprite").queue_free()

func remove_self():
	print("removing everything")
	queue_free()
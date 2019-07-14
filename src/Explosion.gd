extends Node2D

var color = Color(1,1,1)

func _ready():
	get_node("Sprite/AnimationPlayer").play("Explode")
	modulate = color
	get_node("Groan").play()

func _on_Animation_complete(anim_name):
	queue_free()
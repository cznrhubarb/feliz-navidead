extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var color = Color(1,1,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Sprite/AnimationPlayer").play("Explode")
	#modulate = color
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Animation_complete(anim_name):
	queue_free()
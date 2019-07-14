extends Node

func _ready():
	get_node("AnimatedSprite").play("default")

func _on_PlayButton_pressed():
	get_tree().change_scene("res://scn/TestScene.tscn")

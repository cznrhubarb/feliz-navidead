extends Node

func _ready():
	get_tree().paused = true

func _on_PlayButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scn/TitleScreen.tscn")

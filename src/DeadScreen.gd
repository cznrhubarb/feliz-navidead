extends Node

func _ready():
	get_tree().paused = true

func _on_PlayButton_pressed():
	print("Pressed obviously")
	print(get_tree().paused)
	get_tree().paused = false
	print(get_tree().paused)
	get_tree().change_scene("res://scn/TitleScreen.tscn")

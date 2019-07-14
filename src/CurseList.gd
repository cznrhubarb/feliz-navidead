extends Node

var icon_count
var icon_width = 16
var icon_spacing = icon_width / 4

func _ready():
	icon_count = 0

func add_curse_icon(resource):
	var icon = Sprite.new()
	icon.texture = load(resource)
	var scene_size = get_viewport().size
	icon.position.x = scene_size.x - (icon_spacing * icon_count + icon_width * (1+icon_count))
	icon.position.y = scene_size.y - icon_width - 4
	add_child(icon)
	icon_count += 1
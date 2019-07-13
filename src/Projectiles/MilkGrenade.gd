extends KinematicBody2D

export var BulletSpeed = 50
const max_life_span = 2
var type = "bullet"
var life_remaining = max_life_span
var spr
var direction = Vector2()

func _ready():
	for child in get_children():
		if child is Sprite:
			spr = child
			break

func _physics_process(delta):
	position += direction * BulletSpeed * delta
	spr.rotation += delta * 3.14
	var scale = (max_life_span/2 - abs(life_remaining - max_life_span/2)) + 1
	spr.scale = Vector2(scale, scale)
	life_remaining -= delta
	if life_remaining <= 0:
		queue_free()
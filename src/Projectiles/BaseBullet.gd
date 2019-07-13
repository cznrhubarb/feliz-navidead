extends KinematicBody2D

var type = "bullet"
var max_life_span
var life_remaining
var bullet_speed
var rotation_speed
var scale_speed
var direction
var sprite
var bullet_type
var current_scale = 1

func build(bullet_spr_name, blt_type, lin_speed, rot_speed, scl_speed, max_life):
	# TODO: add sprite and shape
#	add_child(load("res://scn/Projectiles/" + bullet_spr_name + "_sprite.tscn").instance())
#	add_child(load("res://scn/Projectiles/" + bullet_spr_name + "_shape.tscn").instance())
#	load("res://scn/CookieBullet.tscn").instance()
	for child in get_children():
		if child is Sprite:
			sprite = child
			break
	bullet_type = blt_type
	bullet_speed = lin_speed
	rotation_speed = rot_speed
	scale_speed = scl_speed
	max_life_span = max_life
	life_remaining = max_life_span

func _physics_process(delta):
	sprite.rotation += delta * 3.14 * rotation_speed
	current_scale += delta * scale_speed
	life_remaining -= delta
	var scale_mod = 0
	match bullet_type:
		"lobbed":
			position += direction * bullet_speed * delta
			scale_mod = (max_life_span/2 - abs(life_remaining - max_life_span/2))
			if life_remaining <= 0:
				destroy_self()
		"shot":
			var collision_info = move_and_collide(direction * bullet_speed * delta)
			if collision_info:
				var collider = collision_info.collider
				if collider.type == "enemy":
					# Deal some damage, don't just kill it
					collider.queue_free()
				destroy_self()
		"melee":
			pass
	
	sprite.scale = Vector2(current_scale + scale_mod, current_scale + scale_mod)

func destroy_self():
	# Explode if necessary. Imagine we just create a bunch of 'shot' type new bullets with short lifespans
	queue_free()
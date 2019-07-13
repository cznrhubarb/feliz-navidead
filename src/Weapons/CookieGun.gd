extends "res://src/Weapons/BaseWeapon.gd"

func cooldown(delta):
	cooldown_timer = max(cooldown_timer - delta, 0)

func shoot(direction, is_auto):
	if cooldown_timer == 0:
		cooldown_timer = cooldown_max
		var bullet_scene = load("res://scn/CookieBullet.tscn")
		var bullet = bullet_scene.instance()
		bullet.direction = direction
		return bullet
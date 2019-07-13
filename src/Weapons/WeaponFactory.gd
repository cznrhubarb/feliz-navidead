
static func make_weapon():
	var bullet_prototype = null
	
	#build(bullet_spr_name, blt_type, lin_speed, rot_speed, scl_speed, max_life):
	if rand_range(0, 1) > 0.5:
		bullet_prototype = load("res://scn/CookieBullet.tscn").instance()
	else:
		bullet_prototype = load("res://scn/MilkGrenade.tscn").instance()
	var shots_per_second = rand_range(0.5, 30)
	
	# Automatic more often than manual
	var auto = true if rand_range(0, 1) > 0.25 else false
	
	# TODO: Manual shot weapons should be stronger
	
	print("shots per second: " + str(shots_per_second))
	print("automatic: " + str(auto))
	return load("res://src/Weapons/BaseWeapon.gd").new(bullet_prototype, shots_per_second, auto)

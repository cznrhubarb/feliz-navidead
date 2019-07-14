
static func make_weapon():
	var bullet_prototype = null
	if rand_range(0, 1) > 0.5:
		bullet_prototype = load("res://scn/CookieBullet.tscn").instance()
	else:
		bullet_prototype = load("res://scn/MilkGrenade.tscn").instance()
	
	bullet_prototype.build("Shoots", 300, 2, 0, 999, 10)
	
	var shots_per_second = stepify(rand_range(0.5, 10), 0.1)
	
	# Automatic more often than manual
	var auto = true if rand_range(0, 1) > 0.25 else false
	# TODO: Manual shot weapons should be stronger on average
	
	var max_scatter_degrees = 15
	var scatter = rand_range(0, deg2rad(max_scatter_degrees))
	
	return load("res://src/Weapons/BaseWeapon.gd").new(bullet_prototype, shots_per_second, auto, scatter)

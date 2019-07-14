
static func make_weapon():
	var bullet_prototype = null
	bullet_prototype = load("res://scn/CookieBullet.tscn").instance()
	
	var shot_speed = rand_range(150, 400)
	var rot_speed = 0
	var scale_speed = max(0, rand_range(-1, 0.5))
	var life_span = rand_range(1, 4)
	
	var shots_per_second = stepify(rand_range(1, 10), 0.1)
	var auto = true if rand_range(0, 1) > 0.5 else false
	
	var max_scatter_degrees = 15
	var scatter = rand_range(0, deg2rad(max_scatter_degrees))
	
	var damage = rand_range(3, 7)
	# Slower bullets deal more damage
	damage += (1 - (shot_speed - 150) / 250) * 5
	# Scaling bullets deal less damage
	damage -= damage * scale_speed
	# Bullets with short life spans deal more damage
	damage += 4 - life_span
	# Faster firing guns deal less damage
	damage -= damage * 0.5 * (shots_per_second-1) / 9
	# Weapons with wider scatter deal more damage
	damage += 2 * (15 - scatter) / 15
	# Manual weapons deal more damage
	if not auto: 
		damage *= 1.5
	
	bullet_prototype.build("Shoots", shot_speed, rot_speed, scale_speed, life_span, round(damage))
	return load("res://src/Weapons/BaseWeapon.gd").new(bullet_prototype, shots_per_second, auto, scatter)

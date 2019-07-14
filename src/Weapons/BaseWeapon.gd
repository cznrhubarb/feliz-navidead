extends Resource

var cooldown_max
var cooldown_timer
var is_automatic
var bullet_prototype
var description
var scatter
var bullet_color

func _init(bullet_proto, shots_per_second, automatic, scatter_amount):
	bullet_color = Color(rand_range(0.5, 1), rand_range(0.5, 1), rand_range(0.5, 1))
	bullet_prototype = bullet_proto
	cooldown_max = 1 / shots_per_second
	cooldown_timer = cooldown_max
	is_automatic = automatic
	scatter = scatter_amount
	description = bullet_proto.bullet_type + " " + str(shots_per_second) + " " + "shots per second.\n" + ("Fully Automatic." if automatic else "Semi Automatic.") + "\n"
	if bullet_proto.damage <= 6:
		description += "Low damage per shot."
	elif bullet_proto.damage <= 10:
		description += "Medium damage per shot."
	else:
		description += "High damage per shot."

func cooldown(delta):
	cooldown_timer = max(cooldown_timer - delta, 0)

func can_shoot(auto_shot):
	if (not is_automatic and auto_shot) or cooldown_timer != 0:
		return false
	else:
		return true

func shoot(direction, auto_shot):
	if can_shoot(auto_shot):
		cooldown_timer = cooldown_max
		var bullet = bullet_prototype.real_duplicate()
		bullet.direction = direction.rotated(rand_range(-scatter, scatter))
		bullet.sprite.modulate = bullet_color
		return bullet
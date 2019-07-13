extends Resource

var cooldown_max
var cooldown_timer
var is_automatic
var bullet_prototype
var description

func _init(bullet_proto, shots_per_second, automatic):
	bullet_prototype = bullet_proto
	cooldown_max = 1 / shots_per_second
	cooldown_timer = cooldown_max
	is_automatic = automatic
	description = bullet_proto.bullet_type + " " + str(shots_per_second) + " " + "bullets" + " per second.\n" + ("Fully Automatic." if automatic else "Semi Automatic.")

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
		bullet.direction = direction
		return bullet
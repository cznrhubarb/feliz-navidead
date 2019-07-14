extends StaticBody2D

var type = "pickup"
var life

func _ready():
	life = randi() % 20 + 5
	
func _on_PickupZone_body_entered(body):
	if body.type == "child":
		picked_up(body)

func picked_up(player):
	if player.health < 100:
		player.health += life
		player.update_health()
		player.game_hud.add_score(life)
		queue_free()

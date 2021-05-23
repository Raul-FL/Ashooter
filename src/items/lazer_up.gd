extends Area2D

var velocity : = Vector2()
var idle_speed = 10
var screen_speed = 15

func _process(delta):
	if position.x > 160:
		var velocity = Vector2(-idle_speed, 0)
		position += velocity * delta
	else:
		var velocity = Vector2(-screen_speed, 0)
		position += velocity * delta
func _on_super_nova_up_area_entered(area):
	if area.is_in_group("player"):
		if Globals.lazer < Globals.max_lazer:
			var sfxref = $AudioStreamPlayer
			remove_child($AudioStreamPlayer)
			get_parent().add_child(sfxref)
			sfxref.play()
			if Globals.lazer+2 <= Globals.max_missile:
				Globals.lazer += 2
			else:
				Globals.lazer = Globals.max_missile
			get_parent().get_node("HUD/secondary_weapons/lazer/LazerCount").text = str(Globals.lazer)
			queue_free()
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
		if Globals.mass_attack < Globals.max_mass_attack:
			var sfxref = $AudioStreamPlayer
			remove_child($AudioStreamPlayer)
			get_parent().add_child(sfxref)
			sfxref.play()
			Globals.mass_attack += 1
			get_parent().get_node("HUD/secondary_weapons/supa_dupa/sd_count").text = str(Globals.mass_attack)
			queue_free()
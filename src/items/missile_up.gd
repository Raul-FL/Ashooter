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
		if Globals.missile < Globals.max_missile:
			var sfxref = $AudioStreamPlayer
			remove_child($AudioStreamPlayer)
			get_parent().add_child(sfxref)
			sfxref.play()
			if Globals.missile+3 <= Globals.max_missile:
				Globals.missile += 3
			else:
				Globals.missile = Globals.max_missile
			get_tree().get_nodes_in_group("HUD").front().get_node("secondary_weapons/missle/missle_count").text = str(Globals.missile)
			queue_free()
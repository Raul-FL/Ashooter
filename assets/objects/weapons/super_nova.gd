extends Area2D

export (int) var attack_power = 20

func _ready():
	$CPUParticles2D.emitting = true
#	$AudioStreamPlayer.play()
	var sfxref = $AudioStreamPlayer
	remove_child($AudioStreamPlayer)
	get_parent().add_child(sfxref)
	sfxref.play()

func _on_Timer_timeout():
	queue_free()

func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		if "set_damage" in area:
			area.set_damage(attack_power)

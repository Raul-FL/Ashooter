extends Area2D

export (int) var attack_power = 15
var hp = 10000

func _on_Timer_timeout():
	get_parent().set_process(true)
	if is_in_group("enemy_lazer"):
		get_parent().get_node("charge").play()
		get_parent().get_node("beam_charge").emitting = true
	queue_free()

extends Area2D

const HOAMING_SHIELD = preload("res://assets/objects/weapons/hoaming_shield/hoaming_shield.tscn")

func _on_super_nova_up_area_entered(area):
	if area.is_in_group("player") && !area.has_node("hoaming_shield"):
		var hoaming_shield = HOAMING_SHIELD.instance()
		area.add_child(hoaming_shield)
		queue_free()
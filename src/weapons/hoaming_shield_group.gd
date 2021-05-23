extends Node2D

const HOAMING_ITEM = preload("res://assets/objects/weapons/hoaming_shield/hoaming_item.tscn")
const hoaming_item_count = 6
var hoaming_items = 0
export(int) var attack_power = 4


func _on_hoaming_timer_timeout():
	var hoaming_item = HOAMING_ITEM.instance()
	if hoaming_items < hoaming_item_count:
		if hoaming_items != 0:
			hoaming_item.attack_power = attack_power
			add_child(hoaming_item)
		hoaming_items += 1

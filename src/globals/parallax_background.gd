extends ParallaxLayer

export var scroll_speed : = 20
var velocity : = Vector2()

func _process(delta):
#	if position.x < get_tree().get_nodes_in_group("player").front().spectrum_left.x:
#		queue_free()

	var velocity = Vector2(-scroll_speed, 0)
	motion_offset.x += velocity.x * delta

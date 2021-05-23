extends Position2D

export var idle_speed : = 10

func _process(delta):
	
	var velocity = Vector2()
	velocity.x += 1
	velocity = velocity * -idle_speed
	position += velocity * delta
	
	
	if position.x < 160:
		if !get_tree().get_nodes_in_group("boss").empty():
#			print(get_tree().get_nodes_in_group("boss"))
			for i in get_tree().get_nodes_in_group("stage"):
				i.scroll_speed = 0
			for i in get_tree().get_nodes_in_group("spawn"):
				i.idle_speed = 0
			for i in get_tree().get_nodes_in_group("item"):
				i.idle_speed = 0
		queue_free()
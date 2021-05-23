extends Camera2D

func _process(delta):
	
	if position.x <= limit_right - 100 && position.x >= limit_right - 110 :
		var HUD = get_tree().get_nodes_in_group("HUD").front()
		var bossu = get_tree().get_nodes_in_group("boss").front()
	
		HUD.get_node("bossu_life").show()
		HUD.get_node("bossu_life").max_value = bossu.hp
		HUD.get_node("bossu_life").value = bossu.hp
	if position.x <= limit_right - 80:
		var velocity = Vector2()
		velocity.x += 1
		velocity = velocity * get_tree().get_nodes_in_group("player").front().idle_speed
		position += velocity * delta
		get_tree().get_nodes_in_group("player").front().spectrum_left += velocity * delta
		get_tree().get_nodes_in_group("player").front().spectrum_right += velocity * delta
		print(get_tree().get_nodes_in_group("player").front().spectrum_right)
	else:
		get_tree().get_nodes_in_group("player").front().idle_speed = 0
		set_process(false)
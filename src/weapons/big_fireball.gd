extends Area2D

export (int) var speed = 100
export (int) var attack_power = 1
export (float) var dir_x
export (float) var dir_y

func _process(delta):
	var velocity = Vector2()
	
	velocity.x += dir_x
	velocity.y += dir_y
	velocity = velocity * speed
	
	position += velocity * delta

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
	if get_parent().get_child_count() == 1:
		get_parent().queue_free()

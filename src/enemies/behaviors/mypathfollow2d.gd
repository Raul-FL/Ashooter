extends Node2D

export var stop_in_the_end : = false

var target
var velocity : = Vector2()
var target_index : = 0
var targets_count
var temp_speed : int

func _ready():
	targets_count = $points.get_child_count() -1
	target = $points.get_children().front()
	temp_speed = get_parent().speed

func _process(delta):
	velocity = Vector2()
	if $single_movement_timer_wait.is_stopped():
		get_parent().speed = 0
		if is_instance_valid(target):
			velocity = Vector2(target.to_point_velocity, 0).rotated((target.position - global_position).angle())
			get_parent().position += velocity * delta
			if get_parent().position.abs().distance_to(target.position.abs()) < 2:
		#		get_parent().position = Vector2(-20,20)
				get_parent().position = target.position
				if target_index < targets_count:
					if target.wait_time == 0:
						target_index += 1
						target = $points.get_children()[target_index]
						$points.get_children().front().queue_free()
						print(target)
					else:
						$wait_timer.wait_time = target.wait_time
						$wait_timer.start()
						set_process(false)
				elif target_index == targets_count:
					print('here')
					if !stop_in_the_end:
						get_parent().speed = temp_speed
					set_process(false)

func _on_wait_timer_timeout():
	print('here')
	$wait_timer.stop()
	get_parent().speed = 0
	target.wait_time = 0
	set_process(true)

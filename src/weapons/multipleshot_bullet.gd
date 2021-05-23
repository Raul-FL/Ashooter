extends Position2D

export (PackedScene) var shoot
export var shot_count : = 10
export var speed : = 10
export var angle : float = 20
export var shot_angle_gap_children : int
export var start_wait_time : float = 2
export var shot_type : = 2
export var special_shot_type : = false
var aux_angle = angle
var wait_time
const EXPLODE_BULLET = preload("res://assets/objects/enemies/enemy_bullets/timer_straight_shot_explode.tscn")

func _ready():
	wait_time = $wait_timer.wait_time
	$wait_timer.wait_time = start_wait_time
	$wait_timer.start()

func _on_wait_timer_timeout():
	
	$AudioStreamPlayer.play()
	
	aux_angle = angle
	
	if shot_count%2 == 0:
		var shot_positive = shot_count/2
		var shot_negative = -shot_count/2
		
		if !special_shot_type:
			for i in range(shot_count):
				var bullet = shoot.instance()
				if shot_type != 0:
					bullet.shot_type = shot_type
				bullet.global_position = global_position
				bullet.speed = speed
				if shot_positive > 0:
					if aux_angle == angle:
						aux_angle = angle/2
	#				print("positive_angle ",aux_angle)
					bullet.angle = aux_angle
					aux_angle += angle
					shot_positive -= 1
					if shot_positive == 0:
						aux_angle = angle
				elif shot_negative < 0:
					if aux_angle == angle:
						aux_angle = -angle/2
	#				print("positive_angle_here ",aux_angle)
					bullet.angle = aux_angle
					aux_angle -= angle
					shot_negative += 1
					if shot_negative == 0:
						aux_angle = 0
				get_tree().current_scene.add_child(bullet)
		else:
			
			for i in range(shot_count):
				var bullet = EXPLODE_BULLET.instance()
				if shot_type != 0:
					bullet.bullet_type = shot_type
				bullet.global_position = global_position
				bullet.speed = speed
				if shot_positive > 0:
					if aux_angle == angle:
						aux_angle = angle/2
	#				print("positive_angle ",aux_angle)
					bullet.angle = aux_angle
					aux_angle += angle
					shot_positive -= 1
					if shot_positive == 0:
						aux_angle = angle
				elif shot_negative < 0:
					if aux_angle == angle:
						aux_angle = -angle/2
	#				print("positive_angle_here ",aux_angle)
					bullet.angle = aux_angle
					aux_angle -= angle
					shot_negative += 1
					if shot_negative == 0:
						aux_angle = 0
				get_tree().current_scene.add_child(bullet)
	else:
		var shot_positive = shot_count/2
		var shot_negative = -shot_count/2
		
		if !special_shot_type:
			for i in range(shot_count):
				var bullet = shoot.instance()
				if shot_type != 0:
					if "shot_type" in bullet:
						bullet.shot_type = shot_type
				bullet.global_position = global_position
				bullet.speed = speed
#				if shot_positive == 0 && rotation_degrees != 0:
#					bullet.angle = rotation_degrees
				if i == 0:
					if rotation_degrees != 0:
						aux_angle = rotation_degrees
						bullet.angle = aux_angle
						aux_angle += angle
				if shot_positive > 0 && !i==0:
					if aux_angle == angle:
						aux_angle = angle
						if rotation_degrees != 0:
							aux_angle += rotation_degrees
	#				print("positive_angle ",aux_angle)
					bullet.angle = aux_angle
					aux_angle += angle
					shot_positive -= 1
					if shot_positive == 0:
						aux_angle = angle
#				elif rotation_degrees != 0 && shot_positive > 0:
#					aux_angle += rotation_degrees
#					bullet.angle = aux_angle
				elif shot_negative < 0 && !i==0:
					if aux_angle == angle:
						aux_angle = -angle
						if rotation_degrees != 0:
							aux_angle += rotation_degrees
	#				print("positive_angle_here ",aux_angle)
					bullet.angle = aux_angle
					aux_angle -= angle
					shot_negative += 1
					if shot_negative == 0:
						aux_angle = 0
				get_tree().current_scene.add_child(bullet)
		else:
			for i in range(shot_count):
				var bullet = EXPLODE_BULLET.instance()
				bullet.dir_shoot = false
				if shot_type != 0:
					bullet.bullet_type = shot_type
				bullet.global_position = global_position
				bullet.speed = speed
				if shot_positive > 0 && !i==0:
					if aux_angle == angle:
						aux_angle = angle
	#				print("positive_angle ",aux_angle)
					bullet.angle = aux_angle
					aux_angle += angle
					shot_positive -= 1
					if shot_positive == 0:
						aux_angle = angle
				elif shot_negative < 0 && !i==0:
					if aux_angle == angle:
						aux_angle = -angle
	#				print("positive_angle_here ",aux_angle)
					bullet.angle = aux_angle
					aux_angle -= angle
					shot_negative += 1
					if shot_negative == 0:
						aux_angle = 0
				get_tree().current_scene.add_child(bullet)

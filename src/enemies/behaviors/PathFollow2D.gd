extends PathFollow2D

export var hp : = 0
export var dir_shot : bool = false
export var shot_type : = 1
export var shot_speed : = 9
export var shot_interval : = 4
export var initial_wait_time : float = 1
export var shot_count : int = 10
export var angle : float = 20
export var die_timer : = false
export (PackedScene) var SHOT
export (PackedScene) var BULLET
export (PackedScene) var BEHAVIOR

export(PackedScene) var PUBLIC_ENEMY
var points : int
export(Array, float) var wait_timers
export(Array, float) var speed_points
var instanced : = false
var i = 1
export var sample_enemy_initial_speed : int
export var stop_in_the_end : = false
var enemy

func _ready():
	points = get_parent().curve.get_point_count()
	wait_timers.resize(get_parent().curve.get_point_count())
	speed_points.resize(get_parent().curve.get_point_count())

func _process(delta):
	if Engine.editor_hint:
		return
#	print(get_parent().curve.get_closest_offset(get_parent().curve.get_point_position(2)))
	
#	print(i)
	if global_position.x < 160:
		if !instanced:
			enemy = PUBLIC_ENEMY.instance()
			if "hp" in enemy:
				if hp > 0:
					enemy.hp = hp
			if die_timer:
				$dead_timer.start()
			enemy.position = Vector2()
#			sample_enemy_initial_speed = enemy.speed
			enemy.speed = 0
			if SHOT:
				var shoot_type = SHOT.instance()
				if "angle_gap" in shoot_type:
					shoot_type.angle_gap = angle
				if "angle" in shoot_type:
					shoot_type.angle = angle
				if "shot_count" in shoot_type:
					shoot_type.shot_count = shot_count
				shoot_type.start_wait_time = initial_wait_time
				if "shot_type" in shoot_type:
					shoot_type.shot_type = shot_type
				if "speed" in shoot_type:
					shoot_type.speed = shot_speed
				if "dir_shoot" in shoot_type:
					shoot_type.dir_shoot = dir_shot
				if "wait_time" in shoot_type:
					shoot_type.wait_time = shot_interval
				if "start_wait_time" in shoot_type:
					shoot_type.start_wait_time = float(shot_interval)
				shoot_type.get_node("wait_timer").wait_time = shot_interval
				shoot_type.position = enemy.get_node("shot_pivot").position
				if "shoot" in shoot_type:
					shoot_type.shoot = BULLET
				enemy.add_child(shoot_type)
			add_child(enemy)
			instanced = true
		if !$Tween.is_active():
			$Tween.interpolate_property(self, "offset", offset, get_parent().curve.get_closest_offset(get_parent().curve.get_point_position(i)), speed_points[i-1], Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			$Tween.start()

func _on_Tween_tween_completed(object, key):
	if i < points-1:
		if wait_timers[i] > 0:
			$wait_time.wait_time = wait_timers[i]
			$wait_time.start()
			set_process(false)
		i += 1
#	elif i == points-1 && !stop_in_the_end:
#		enemy.speed = sample_enemy_initial_speed


func _on_wait_time_timeout():
	set_process(true)


func _on_dead_timer_timeout():
#	if instanced && get_child_count() == 3:
#		get_parent().queue_free()
	get_parent().queue_free()

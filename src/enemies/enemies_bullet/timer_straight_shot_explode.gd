extends Position2D

export (PackedScene) var shoot
export var speed : = 10
export var start_wait_time : float = 2
export var dir_shoot : = false
export var wave_shoot : = false
export var shot_count : = 2
export var explode_wait_time : = 1
export var shot_type : = 2
var angle : float = 0
export var angle_gap : float = 65
var MULTIPLE_SHOT
var target_position : Vector2
var wait_time

func _ready():
#	if dir_shoot:
	MULTIPLE_SHOT = load("res://assets/objects/enemies/enemy_bullets/multipleshot_bullet.tscn")
#		target_position = get_tree().get_nodes_in_group("player").front().global_position
	wait_time = $wait_timer.wait_time
	$wait_timer.wait_time = start_wait_time
	$wait_timer.start()

func _on_explode_timer_timeout():
#	print('here')
	var multiple_shot = MULTIPLE_SHOT.instance()
	if shot_type != 0:
		multiple_shot.shot_type = shot_type
	multiple_shot.shoot = shoot
	multiple_shot.shot_count = shot_count
	multiple_shot.angle = angle_gap
	multiple_shot.start_wait_time = 0.0
	multiple_shot.get_node("wait_timer").one_shot = true
	multiple_shot.global_position = get_tree().get_nodes_in_group("multiple_shot").front().global_position
	get_tree().current_scene.add_child(multiple_shot)
	get_tree().get_nodes_in_group("multiple_shot").front().queue_free()

func _kill_me_please():
	print(get_tree().get_nodes_in_group("multiple_shot").size())

func _on_wait_timer_timeout():
	
	$AudioStreamPlayer.play()
	
	var explode_timer = Timer.new()
	explode_timer.wait_time = explode_wait_time
	explode_timer.one_shot = true
	explode_timer.connect("timeout", self, "_on_explode_timer_timeout")
	explode_timer.add_to_group("multiple_shot_timers")
	
	var shut = shoot.instance()
	shut.angle = angle
	if shot_type != 0:
		shut.shot_type = shot_type
	shut.connect("tree_exiting", self, "_kill_me_please")
	shut.add_child(explode_timer)
	
	explode_timer.start()
	shut.speed = speed
	shut.add_to_group("multiple_shot")
	shut.position = global_position
	if dir_shoot:
		shut.dir_shot = true
	if wave_shoot:
		shut.enable_wave_shoot = true
	get_tree().current_scene.add_child(shut)
	$wait_timer.wait_time = wait_time
	$wait_timer.start()

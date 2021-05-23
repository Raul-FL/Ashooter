extends Position2D

export (PackedScene) var shoot
export var speed : = 10
export var start_wait_time : float = 2
export var dir_shoot : = false
export var wave_shoot : = false
export var wave_lenght : int = 20
export var wave_speed : float = 1
export var shot_type : = 2
var WAVE_SHOT = preload("res://assets/objects/enemies/enemies_behaviors/wave_movement.tscn")
var target_position : Vector2
var wait_time

func _ready():
#	if dir_shoot:
#		target_position = get_tree().get_nodes_in_group("player").front().global_position
	wait_time = $wait_timer.wait_time
	$wait_timer.wait_time = start_wait_time
#	$wait_timer.start()

func _on_wait_timer_timeout():
	
	$AudioStreamPlayer.play()
	
	var shut = shoot.instance()
	if "shot_type" in shut:
		shut.shot_type = shot_type
	shut.speed = speed
	shut.position = global_position
	if dir_shoot:
		shut.dir_shot = true
	if wave_shoot:
		var wave_shot = WAVE_SHOT.instance()
		wave_shot.wave_lenght = wave_lenght
		wave_shot.wave_speed = wave_speed
		shut.add_child(wave_shot)
	get_tree().current_scene.add_child(shut)
	$wait_timer.wait_time = wait_time
	$wait_timer.start()

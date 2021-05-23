#tool
extends Position2D

const LAZER = preload("res://assets/objects/enemies/enemy_bullets/enemy_lazer.tscn")
export var straight : = false
export var start_wait_time : float = 2
var wait_time
var temp_player_position

func _ready():
	
	wait_time = $wait_timer.wait_time
	$wait_timer.wait_time = start_wait_time
#	$wait_timer.start()

func _process(delta):
	if Engine.editor_hint:
		return
	update()

func _draw():
	if !straight:
		draw_line(Vector2(), (get_tree().get_nodes_in_group("player").front().get_node("explosion_position").global_position - global_position) * 50, Color('#306230'), 0.5, true)
	else:
		draw_line(Vector2(), Vector2(-160, 0), Color('#306230'), 1)


func _on_wait_timer_timeout():
	$delay_timer.start()
	temp_player_position = get_tree().get_nodes_in_group("player").front().get_node("explosion_position").global_position
	if !straight:
		set_process(false)


func _on_delay_timer_timeout():
	$beam_charge.emitting = false
	$charge.stop()
	$delay_timer.stop()
	var lazer = LAZER.instance()
	if !straight:
		lazer.rotation = (global_position - temp_player_position).angle()
	add_child(lazer)
	

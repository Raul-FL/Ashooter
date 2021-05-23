extends Area2D

export (int) var speed = 0
export (int) var hp = 30
export (int) var score = 1
export var stage_clear : = false
export var final_stage : = false
var angle
var rotate_with_angle
const EXPLOSION = preload("res://assets/objects/sfx/boss_explosion.tscn")

func _process(delta):
	var velocity = Vector2()
	velocity.x -= 1
	velocity = velocity * speed

	position += velocity * delta

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()

func set_damage(amount):
	hp -= amount
#	get_tree().get_nodes_in_group("HUD").front().get_node("bossu_life").value -= amount
	if hp <= 0:
		get_tree().get_nodes_in_group("HUD").front().get_node("bossu_life").hide()
		
		
		var sfxref = $AudioStreamPlayer
		remove_child($AudioStreamPlayer)
		get_parent().add_child(sfxref)
		sfxref.play()
		
		var explosion = EXPLOSION.instance()
		
		get_parent().add_child(explosion)
		explosion.position = global_position
		Globals.score += score
		get_tree().get_nodes_in_group("HUD").front().get_node("Score/Score_count").text = str(Globals.score)
		queue_free()

func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet"):
		area.queue_free()
		set_damage(area.attack_power)
	if area.is_in_group("beam"):
		set_damage(area.attack_power)

#func _on_VisibilityNotifier2D_viewport_entered(viewport):
#
#	var HUD = get_tree().get_nodes_in_group("HUD").front()
#
#	HUD.get_node("bossu_life").show()
#	HUD.get_node("bossu_life").max_value = hp
#	HUD.get_node("bossu_life").value = hp


func _on_VisibilityNotifier2D_tree_exiting():
	
	var HUD = get_tree().get_nodes_in_group("HUD").front()
	
	HUD.get_node("bossu_life").hide()


func _on_wait_time_to_stop_timeout():
	speed = 0

func _on_finalbossu_stop_timeout():
	$multipleshot_bullet/wait_timer.start()
	$timer_straight_shot/wait_timer.start()
	$charge_beam/wait_timer.start()
	speed = 0
	if stage_clear:
		pass

func _on_ojehti_tree_exiting():
	if final_stage:
		for i in get_tree().get_nodes_in_group("spawn"):
			i.idle_speed = 10
		for i in get_tree().get_nodes_in_group("stage"):
			i.scroll_speed = 10
		for i in get_tree().get_nodes_in_group("item"):
			i.idle_speed = 10
	else:
		get_tree().get_nodes_in_group("player").front().set_process(false)
		get_tree().get_nodes_in_group("player").front().monitoring = false
		get_tree().get_nodes_in_group("player").front().get_node("hurt_timer").stop()
#		print(get_tree().get_nodes_in_group("player").front().monitoring)
		
		get_tree().get_nodes_in_group("player").front().get_node("AnimationPlayer").play("finished_stage")
		
	if stage_clear:
		get_parent().get_node("Label").show()
		
func _on_cerberus_tree_exiting():
	if final_stage:
		for i in get_tree().get_nodes_in_group("spawn"):
			i.idle_speed = 10
		for i in get_tree().get_nodes_in_group("stage"):
			i.scroll_speed = 10
		for i in get_tree().get_nodes_in_group("item"):
			i.idle_speed = 10
		for i in get_tree().get_nodes_in_group("enemy_bullet"):
			i.queue_free()
	else:
		get_tree().get_nodes_in_group("player").front().set_process(false)
		get_tree().get_nodes_in_group("player").front().monitoring = false
		get_tree().get_nodes_in_group("player").front().get_node("hurt_timer").stop()
#		print(get_tree().get_nodes_in_group("player").front().monitoring)
		
		get_tree().get_nodes_in_group("player").front().get_node("AnimationPlayer").play("finished_stage")
		
	if stage_clear:
		get_parent().get_node("Label").show()

func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.queue_free()

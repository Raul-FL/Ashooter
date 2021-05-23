extends Area2D

const EXPLOSION = preload("res://assets/objects/sfx/explosion.tscn")

export var attack_power = 7
var target
var my_owner = true
export(int) var speed = 100

func _ready():
	$AudioStreamPlayer.play()
	if !get_tree().get_nodes_in_group("enemy").empty():
		var lesser = get_tree().get_nodes_in_group("enemy").front()
#		print((get_tree().get_nodes_in_group("player").front().global_position - lesser.global_position).abs())
		for i in get_tree().get_nodes_in_group("enemy"):
			if global_position.distance_to(lesser.global_position) > global_position.distance_to(i.global_position):
#				if global_position > i.global_position:
				
					lesser = i
		target = lesser
#	rotation = (target.position - position).angle()

func _process(delta):
	if global_position.x > 160:
		queue_free()
	if is_instance_valid(target):
		rotation = (target.global_position - global_position).angle()
	elif !get_tree().get_nodes_in_group("enemy").empty() && my_owner:
		target = get_tree().get_nodes_in_group("enemy").front()
	var velocity = Vector2()
	
	if is_instance_valid(target) && target.global_position.x < get_tree().get_nodes_in_group("player").front().spectrum_right.x:
		velocity = Vector2(speed, 0).rotated((target.global_position - global_position).angle())
	else:
		velocity = Vector2(speed, 0)
	
	position += velocity * delta
	

func _on_hoaming_missile_area_entered(area):
	if area.is_in_group("enemy"):
		var explosion = EXPLOSION.instance()
		get_parent().add_child(explosion)
#		speed = 0
#		$Sprite.visible = false
#		$CPUParticles2D.visible = false
		explosion.emitting = true
		explosion.position = position
		queue_free()




func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.queue_free()


func _on_hoaming_missile_body_entered(body):
	var explosion = EXPLOSION.instance()
	get_parent().add_child(explosion)
	explosion.emitting = true
	explosion.position = position
	queue_free()

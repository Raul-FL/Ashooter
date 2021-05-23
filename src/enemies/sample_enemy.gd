extends Area2D

export (int) var speed = 0
export (int) var hp = 3
export (int) var score = 1
export var rotate_with_angle : = false
var angle : float
const EXPLOSION = preload("res://assets/objects/sfx/explosion.tscn")

func _ready():
	if rotate_with_angle:
		rotation_degrees = angle\

func _process(delta):
#	print(global_position)
	if position.x < 0:
		queue_free()
	
	var velocity = Vector2()
	velocity = Vector2(-speed, 0).rotated(deg2rad(angle))
	position += velocity * delta

#func _on_VisibilityNotifier2D_viewport_exited(viewport):
#	queue_free()

func set_damage(amount):
	hp -= amount
	if hp <= 0:
		
		var sfxref = $AudioStreamPlayer
		remove_child($AudioStreamPlayer)
		get_parent().add_child(sfxref)
		sfxref.play()
		
		
		var explosion = EXPLOSION.instance()
		explosion.position = global_position
		get_tree().current_scene.add_child(explosion)
		Globals.score += score
		get_tree().get_nodes_in_group("HUD").front().get_node("Score/Score_count").text = str(Globals.score)
		queue_free()

func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet"):
		area.queue_free()
		set_damage(area.attack_power)
	if area.is_in_group("beam"):
		set_damage(area.attack_power)



func _on_Die_timeout():
	queue_free()

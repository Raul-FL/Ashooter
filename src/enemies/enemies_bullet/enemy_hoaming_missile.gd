extends Area2D

const EXPLOSION = preload("res://assets/objects/sfx/explosion.tscn")

var attack_power = 4
var target
var my_owner = true
export(int) var speed = 100

func _ready():

	target = get_tree().get_nodes_in_group("player").front().get_node("explosion_position")
#	rotation = (target.position - position).angle()

func _process(delta):
	rotation = (target.global_position - global_position).angle()
	var velocity = Vector2()
	
	if is_instance_valid(target) && target.position.x < get_tree().get_nodes_in_group("player").front().spectrum_right.x:
		velocity = Vector2(speed, 0).rotated((target.global_position - global_position).angle())
	else:
		velocity = Vector2(speed, 0)
	
	position += velocity * delta
	

func _on_hoaming_missile_area_entered(area):
	if area.is_in_group("player"):
		var explosion = EXPLOSION.instance()
		get_parent().add_child(explosion)
#		speed = 0
#		$Sprite.visible = false
#		$CPUParticles2D.visible = false
		explosion.emitting = true
		explosion.position = position
		queue_free()


func _on_expire_timer_timeout():
	queue_free()

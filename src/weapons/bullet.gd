extends Area2D

export (int) var speed = 200
export (int) var attack_power = 1
var direction = 1

func _ready():
	$AudioStreamPlayer2D.play()

func _process(delta):
#	if position.x > get_tree().get_nodes_in_group("player").front().spectrum_right.x:
#		queue_free()
	
	var velocity = Vector2()
	velocity.x += direction
	velocity = velocity * speed
	
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

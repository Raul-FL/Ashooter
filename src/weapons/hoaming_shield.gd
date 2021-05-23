extends Area2D

var speed = 2*PI
var radius = 1.7
var angle = 0
export (int) var attack_power = 4

func _process(delta):
	angle += speed * delta
	position.x += cos(angle) * radius
	position.y += sin(angle) * radius
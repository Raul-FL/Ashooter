extends Position2D

export (PackedScene) var BULLET
export var speed : = 10
var target_position : Vector2
var bullet

func _ready():
	target_position = get_tree().get_nodes_in_group("player").front().global_position
	bullet = BULLET.instance()
	bullet.speed = speed
	call_deferred("add_my_child", bullet)
#	bullet.angle = rad2deg((target_position - bullet.global_position).angle())

func add_my_child(bullet):
	get_parent().get_parent().add_child(bullet)


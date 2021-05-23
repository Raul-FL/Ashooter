extends Area2D

export (int) var speed = 200
export (int) var attack_power = 1
var direction = -1
var angle = 0
var dir_shot = false
var enable_wave_shoot = false
const WAVE_SHOT = preload("res://assets/objects/enemies/enemies_behaviors/wave_movement.tscn")
const SHOT0 = preload("res://assets/sprites/weapons/weapons.sprites/simple_shot_night.tres")
const SHOT1 = preload("res://assets/sprites/enemies/enemy_weapons/enemy_shot1.png")
const SHOT2 = preload("res://assets/sprites/enemies/enemy_weapons/enemy_shot.png")
var shot_type : = 0

func _ready():
	if shot_type == 1:
		$bullet_day.texture = SHOT1
	if shot_type == 2:
		$bullet_day.texture = SHOT2
	
	if dir_shot:
		angle = rad2deg((global_position - get_tree().get_nodes_in_group("player").front().global_position).angle())
	if enable_wave_shoot:
		var wave_shot = WAVE_SHOT.instance()
		add_child(wave_shot)

func _process(delta):
#	if position.x > get_tree().get_nodes_in_group("player").front().spectrum_right.x:
#		queue_free()
	
	var velocity = Vector2()
	velocity.x += direction
	velocity = velocity * speed
	velocity = velocity.rotated(deg2rad(angle))
	
	position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

extends Node

export var wave_lenght : = 10
export var wave_speed : = 0.4
export var inverted : = false
var velocity : = Vector2()
var actual_wave_length : int
var negative_actual_wave_lenght : int
var true_wave_lenght : int

func _ready():
	actual_wave_length = get_parent().global_position.y + wave_lenght
	print("actual_wave_length ", actual_wave_length)
	negative_actual_wave_lenght = get_parent().global_position.y - wave_lenght
	print("negative_actual_wave_length ", negative_actual_wave_lenght)
	true_wave_lenght = actual_wave_length

func _process(delta):
		if !$Tween.is_active():
			$Tween.interpolate_property(get_parent(), "global_position:y", get_parent().global_position.y, true_wave_lenght, wave_speed,Tween.TRANS_QUAD,Tween.EASE_IN_OUT)
			$Tween.start()
#		print(get_parent().position)

#func _on_Tween_tween_all_completed():
#	print('here')
#	inverted = !inverted


func _on_Tween_tween_completed(object, key):
	print('here')
	if true_wave_lenght == actual_wave_length:
		true_wave_lenght = negative_actual_wave_lenght
	elif true_wave_lenght == negative_actual_wave_lenght:
		true_wave_lenght = actual_wave_length

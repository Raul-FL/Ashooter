extends CanvasLayer

var menu_items = 1
var menu_index = 0

func _input(event):
	if Input.is_action_just_pressed("pause") && !$Control.visible:
		get_tree().paused = true
		$Control.visible = true
	elif Input.is_action_just_pressed("pause") && $Control.visible:
		get_tree().paused = false
		$Control.visible = false
	
	if (Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("attack")) && menu_index == 0 && $Control.visible == true:
		get_tree().paused = false
		$Control.visible = false

	if (Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("attack")) && menu_index == 1 && $Control.visible == true:
		get_tree().paused = false
		Globals.reset_stats()
		Globals.goto_scene("res://assets/stages/IntroScreen.tscn")
	
	if Input.is_action_just_pressed("ui_down") && menu_index == 0:
		$Control/resume/bg.hide()
		$Control/resume/sprite_selected.hide()
		$Control/quit/bg.show()
		$Control/quit/sprite_selected.show()
		menu_index += 1
	if Input.is_action_just_pressed("ui_up") && menu_index == 1:
		$Control/quit/bg.hide()
		$Control/quit/sprite_selected.hide()
		$Control/resume/bg.show()
		$Control/resume/sprite_selected.show()
		menu_index -= 1
	

func _on_Control_hide():
	$Control/resume/bg.show()
	$Control/resume/sprite_selected.show()
	$Control/quit/bg.hide()
	$Control/quit/sprite_selected.hide()

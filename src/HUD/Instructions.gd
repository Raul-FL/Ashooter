extends Node2D

var passa = false
var passa2 = false


func _ready():
	pass

func _input(event):
	if (Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_right")) && $default.visible == true:
		$default.hide()
		$Node2D.show()
	elif (Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_right")) && $default.visible == false:
		$default.show()
		$Node2D.hide()
	if Input.is_action_just_pressed("subweapon") || Input.is_action_just_pressed("pause"):
		Globals.goto_scene("res://assets/stages/IntroScreen.tscn")
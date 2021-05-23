extends Node2D

var menu_items = 2
var menu_index = 0

func _ready():
	Globals.stage = 0
	$start/Start2.visible = true
	$start/ColorRect.visible = true
	
	$instructions/ColorRect2.visible = false
	$instructions/Instructions2.visible = false
	
	$credits/Quit2.visible = false
	$credits/ColorRect3.visible = false
	
func _input(event):
	if Input.is_action_just_pressed("ui_down") && menu_index == 0:
		$start/Start2.visible = false
		$start/ColorRect.visible = false
		
		$instructions/ColorRect2.visible = true
		$instructions/Instructions2.visible = true
		
		menu_index +=1
		
	elif Input.is_action_just_pressed("ui_down") && menu_index == 1:
		$instructions/ColorRect2.visible = false
		$instructions/Instructions2.visible = false
		
		$credits/Quit2.visible = true
		$credits/ColorRect3.visible = true
		menu_index +=1
	elif Input.is_action_just_pressed("ui_up") && menu_index == 1:
		$start/Start2.visible = true
		$start/ColorRect.visible = true
		
		$instructions/ColorRect2.visible = false
		$instructions/Instructions2.visible = false
		
		menu_index -=1
		
	elif Input.is_action_just_pressed("ui_up") && menu_index == 2:
		$instructions/ColorRect2.visible = true
		$instructions/Instructions2.visible = true
		
		$credits/Quit2.visible = false
		$credits/ColorRect3.visible = false
		menu_index -=1
	
	
	if (Input.is_action_just_pressed("ui_accept") || Input.is_action_pressed("attack")) && menu_index == 0:
		Globals.goto_scene("res://assets/stages/debug_stage.tscn")
	if Input.is_action_just_pressed("ui_accept") && menu_index == 1:
		Globals.goto_scene("res://assets/stages/Instructions.tscn")
	if Input.is_action_just_pressed("ui_accept") && menu_index == 2:
		get_tree().quit()
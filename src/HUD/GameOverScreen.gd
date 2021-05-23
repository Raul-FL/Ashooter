extends Control

var menu_items = 1
var menu_index = 0

func _ready():
	$Credits_count.text = str(Globals.credits)

func _input(event):
	if Input.is_action_just_pressed("ui_right") && menu_index == 0:
		$YES/Label2.hide()
		$YES/ColorRect.hide()
		
		$NO/Label2.show()
		$NO/ColorRect.show()
		menu_index +=1
		
	if Input.is_action_just_pressed("ui_left") && menu_index == 1:
		$NO/Label2.hide()
		$NO/ColorRect.hide()
		
		$YES/Label2.show()
		$YES/ColorRect.show()
		menu_index -= 1
	
	if Input.is_action_just_pressed("ui_accept") && menu_index == 1:
		Globals.goto_scene("res://assets/stages/TrueGameOverScreen.tscn")
		
	if Input.is_action_just_pressed("ui_accept") && menu_index == 0 && Globals.credits > 0:
		Globals.credits -= 1
		Globals.reset_stats()
		if Globals.stage == 0:
			Globals.goto_scene("res://assets/stages/debug_stage.tscn")
		if Globals.stage == 1:
			Globals.goto_scene("res://assets/stages/truestages/stage2.tscn")
		if Globals.stage == 2:
			Globals.goto_scene("res://assets/stages/truestages/stage3.tscn")
		if Globals.stage == 3:
			Globals.goto_scene("res://assets/stages/truestages/stage4.tscn")
		if Globals.stage == 4:
			Globals.goto_scene("res://assets/stages/truestages/stage5.tscn")
		if Globals.stage == 5:
			Globals.goto_scene("res://assets/stages/truestages/final_stage.tscn")
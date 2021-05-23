extends Control

func _ready():
	pass


func _on_Timer_timeout():
	Globals.reset_stats()
	Globals.score = 0
	Globals.credits = 2
	Globals.goto_scene("res://assets/stages/IntroScreen.tscn")

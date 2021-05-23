extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var stage : = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.stage = stage


func _on_Timer_timeout():
	hide()

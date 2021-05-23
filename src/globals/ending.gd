extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	$AudioStreamPlayer2.play()
	$AnimatedSprite2.show()
	$Label.show()
	$Timer.start()


func _on_Timer_timeout():
	$AnimatedSprite2.frame = 1
	$Label.hide()
	$Label2.show()
	$Timer2.start()


func _on_Timer2_timeout():
	$Label2.hide()
	$AnimatedSprite2.hide()
	$Label3.show()
	$Timer3.start()


func _on_Timer3_timeout():
	$Label3.hide()
	$Label4.show()
	$Timer4.start()


func _on_Timer4_timeout():
	$Label4.hide()
	$Label5.show()
	$Label6.text = str(Globals.score)
	$Label6.show()
	$Timer6.start()




func _on_Timer5_timeout():
	$AudioStreamPlayer.stop()
	$final_explosion.play()


func _on_Timer6_timeout():
	Globals.goto_scene("res://assets/stages/TrueGameOverScreen.tscn")

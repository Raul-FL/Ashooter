extends Area2D

var velocity : = Vector2()
var idle_speed = 10
var screen_speed = 15

func _process(delta):
	if position.x > 160:
		var velocity = Vector2(-idle_speed, 0)
		position += velocity * delta
	else:
		var velocity = Vector2(-screen_speed, 0)
		position += velocity * delta

func _on_heart_up_area_entered(area):
	if area.is_in_group("player"):
		var sfxref = $AudioStreamPlayer
		remove_child($AudioStreamPlayer)
		get_parent().add_child(sfxref)
		sfxref.play()
		Globals.hp = 4
		get_tree().get_nodes_in_group("HUD").front().get_node("TextureProgress").value = 4
		if Globals.lifes < Globals.max_lifes:
			if Globals.lifes == 5:
				get_parent().get_node("HUD/hearts/heart0").show()
				get_parent().get_node("HUD/hearts/heart1").show()
				get_parent().get_node("HUD/hearts/heart2").show()
				get_parent().get_node("HUD/hearts/heart3").show()
				get_parent().get_node("HUD/hearts/heart4").show()
				get_parent().get_node("HUD/hearts/heart5").show()
			if Globals.lifes == 4:
				get_parent().get_node("HUD/hearts/heart0").show()
				get_parent().get_node("HUD/hearts/heart1").show()
				get_parent().get_node("HUD/hearts/heart2").show()
				get_parent().get_node("HUD/hearts/heart3").show()
				get_parent().get_node("HUD/hearts/heart4").show()
				get_parent().get_node("HUD/hearts/heart5").hide()
			if Globals.lifes == 3:
				get_parent().get_node("HUD/hearts/heart0").show()
				get_parent().get_node("HUD/hearts/heart1").show()
				get_parent().get_node("HUD/hearts/heart2").show()
				get_parent().get_node("HUD/hearts/heart3").show()
				get_parent().get_node("HUD/hearts/heart4").hide()
				get_parent().get_node("HUD/hearts/heart5").hide()
			if Globals.lifes == 2:
				get_parent().get_node("HUD/hearts/heart0").show()
				get_parent().get_node("HUD/hearts/heart1").show()
				get_parent().get_node("HUD/hearts/heart2").show()
				get_parent().get_node("HUD/hearts/heart3").hide()
				get_parent().get_node("HUD/hearts/heart4").hide()
				get_parent().get_node("HUD/hearts/heart5").hide()
			if Globals.lifes == 1:
				get_parent().get_node("HUD/hearts/heart0").show()
				get_parent().get_node("HUD/hearts/heart1").show()
				get_parent().get_node("HUD/hearts/heart2").hide()
				get_parent().get_node("HUD/hearts/heart3").hide()
				get_parent().get_node("HUD/hearts/heart4").hide()
				get_parent().get_node("HUD/hearts/heart5").hide()
			if Globals.lifes == 0:
				get_parent().get_node("HUD/hearts/heart0").show()
				get_parent().get_node("HUD/hearts/heart1").hide()
				get_parent().get_node("HUD/hearts/heart2").hide()
				get_parent().get_node("HUD/hearts/heart3").hide()
				get_parent().get_node("HUD/hearts/heart4").hide()
				get_parent().get_node("HUD/hearts/heart5").hide()
			Globals.lifes += 1
			queue_free()

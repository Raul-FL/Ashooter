extends CanvasLayer

var menu_items = 2
var menu_index = 0

func _ready():
#	if !get_tree().get_nodes_in_group("boss").empty():
#		$bossu_life.show()
#		$bossu_life.max_value = get_tree().get_nodes_in_group("boss").front().hp
#		$bossu_life.value = get_tree().get_nodes_in_group("boss").front().hp
	$secondary_weapons/missle/missle_count.text = str(Globals.missile)
	$secondary_weapons/lazer/LazerCount.text = str(Globals.lazer)
	$secondary_weapons/supa_dupa/sd_count.text = str(Globals.mass_attack)
	$Score/Score_count.text = str(Globals.score)
	
	
	$TextureProgress.value = Globals.hp
	if Globals.lifes == 6:
		$hearts/heart0.visible = true
		$hearts/heart1.visible = true
		$hearts/heart2.visible = true
		$hearts/heart3.visible = true
		$hearts/heart4.visible = true
		$hearts/heart5.visible = true
	if Globals.lifes == 5:
		$hearts/heart0.visible = true
		$hearts/heart1.visible = true
		$hearts/heart2.visible = true
		$hearts/heart3.visible = true
		$hearts/heart4.visible = true
		$hearts/heart5.visible = false
	if Globals.lifes == 4:
		$hearts/heart0.visible = true
		$hearts/heart1.visible = true
		$hearts/heart2.visible = true
		$hearts/heart3.visible = true
		$hearts/heart4.visible = false
		$hearts/heart5.visible = false
	if Globals.lifes == 3:
		$hearts/heart0.visible = true
		$hearts/heart1.visible = true
		$hearts/heart2.visible = true
		$hearts/heart3.visible = false
		$hearts/heart4.visible = false
		$hearts/heart5.visible = false
	if Globals.lifes == 2:
		$hearts/heart0.visible = true
		$hearts/heart1.visible = true
		$hearts/heart2.visible = false
		$hearts/heart3.visible = false
		$hearts/heart4.visible = false
		$hearts/heart5.visible = false
	if Globals.lifes == 1:
		$hearts/heart0.visible = true
		$hearts/heart1.visible = false
		$hearts/heart2.visible = false
		$hearts/heart3.visible = false
		$hearts/heart4.visible = false
		$hearts/heart5.visible = false
	if Globals.lifes == 0:
		$hearts/heart0.visible = false
		$hearts/heart1.visible = false
		$hearts/heart2.visible = false
		$hearts/heart3.visible = false
		$hearts/heart4.visible = false
		$hearts/heart5.visible = false



func _input(event):
	if Input.is_action_just_pressed("switch_item_right") && menu_index == 0:
		$secondary_weapons/lazer/Sprite.hide()
		$secondary_weapons/lazer/ColorRect.show()
		$secondary_weapons/lazer/reverse_sprite.show()
		
		$secondary_weapons/missle/Sprite.show()
		$secondary_weapons/missle/ColorRect.hide()
		$secondary_weapons/missle/reverse_sprite.hide()
		menu_index += 1
		
	elif Input.is_action_just_pressed("switch_item_right") && menu_index == 1:
		$secondary_weapons/supa_dupa/Sprite.hide()
		$secondary_weapons/supa_dupa/ColorRect.show()
		$secondary_weapons/supa_dupa/reverse_sprite.show()
		
		$secondary_weapons/lazer/Sprite.show()
		$secondary_weapons/lazer/ColorRect.hide()
		$secondary_weapons/lazer/reverse_sprite.hide()
		menu_index += 1
		
	elif Input.is_action_just_pressed("switch_item_left") && menu_index == 2:
		$secondary_weapons/lazer/Sprite.hide()
		$secondary_weapons/lazer/ColorRect.show()
		$secondary_weapons/lazer/reverse_sprite.show()
		
		$secondary_weapons/supa_dupa/Sprite.show()
		$secondary_weapons/supa_dupa/ColorRect.hide()
		$secondary_weapons/supa_dupa/reverse_sprite.hide()
		menu_index -= 1
		
	elif Input.is_action_just_pressed("switch_item_left") && menu_index == 1:
		$secondary_weapons/missle/Sprite.hide()
		$secondary_weapons/missle/ColorRect.show()
		$secondary_weapons/missle/reverse_sprite.show()
		
		$secondary_weapons/lazer/Sprite.show()
		$secondary_weapons/lazer/ColorRect.hide()
		$secondary_weapons/lazer/reverse_sprite.hide()
		
		menu_index -= 1
		
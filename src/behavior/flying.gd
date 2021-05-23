extends Area2D

export (int) var speed = 100
var screen_size
const BULLET = preload("res://assets/objects/weapons/bullet.tscn")
const EXPLOSION = preload("res://assets/objects/sfx/explosion.tscn")
const LAZER = preload("res://assets/objects/weapons/lazer.tscn")
const HOAMING_SHIELD = preload("res://assets/objects/weapons/hoaming_shield/hoaming_shield.tscn")
const SUPER_NOVA = preload("res://assets/objects/weapons/super_nova.tscn")
const HOAMING_MISSILE = preload("res://assets/objects/weapons/hoaming_missile.tscn")
export (PackedScene) var nextScene
var canvasx
var spectrum_left = Vector2()
var spectrum_right = Vector2(160,0)
var gameover : = false

func _ready():
	screen_size = get_viewport_rect().size
	canvasx = -6


func _process(delta):
	if gameover:
		monitoring = false
	
	var velocity = Vector2()
	var screen_velocity = Vector2()
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	
	screen_velocity.x += 1
#	screen_velocity = screen_velocity * idle_speed
	
	velocity = velocity * speed
	
	
#	position += screen_velocity * delta
	position += velocity * delta
	position.x = clamp(position.x, -2, screen_size.x -21)
	position.y = clamp(position.y, 13, screen_size.y -10)
	
	if Input.is_action_just_pressed("attack"):
		var bullet = BULLET.instance()
		get_parent().add_child(bullet)
		bullet.position = $shot_position.global_position
	
	if Input.is_action_just_pressed("subweapon") && get_tree().get_nodes_in_group("HUD").front().menu_index == 1 && Globals.lazer != 0:
		var lazer = LAZER.instance()
		add_child(lazer)
		lazer.position = $shot_position.position
		lazer.position.y = 8
		Globals.lazer -= 1
		get_parent().get_node("HUD/secondary_weapons/lazer/LazerCount").text = str(Globals.lazer)
	
#	if Input.is_action_just_pressed("subweapon1") && !has_node("hoaming_shield"):
#		var hoaming_shield = HOAMING_SHIELD.instance()
#		add_child(hoaming_shield)
		
	if Input.is_action_just_pressed("subweapon") && get_tree().get_nodes_in_group("HUD").front().menu_index == 2 && Globals.mass_attack != 0:
		var super_nova = SUPER_NOVA.instance()
		get_parent().add_child(super_nova)
		super_nova.position = $shot_position.global_position
		Globals.mass_attack -= 1
		get_parent().get_node("HUD/secondary_weapons/supa_dupa/sd_count").text = str(Globals.mass_attack)
#		if !get_tree().get_nodes_in_group("enemy").empty():
#			for i in get_tree().get_nodes_in_group("enemy"):
#				if i.get_node("VisibilityNotifier2D").is_on_screen():
#					i.set_damage(10)
		
		

	if Input.is_action_just_pressed("subweapon") && get_tree().get_nodes_in_group("HUD").front().menu_index == 0 && Globals.missile != 0:
		var hoaming_missile = HOAMING_MISSILE.instance()
		hoaming_missile.global_position = $missile_position.global_position
		get_parent().add_child(hoaming_missile)
#		hoaming_missile.position = $missile_position.global_position
		Globals.missile -= 1
		get_tree().get_nodes_in_group("HUD").front().get_node("secondary_weapons/missle/missle_count").text = str(Globals.missile)

func _on_Spaceship_area_entered(area):
	if area.is_in_group("enemy") || area.is_in_group("enemy_bullet") || area.is_in_group("enemy_lazer"):
#		set_collision_mask_bit(0, false)
#		set_collision_mask_bit(1, false)
		set_collision_mask_bit(2, false)
		set_collision_layer_bit(0, false)
		if $hurt_timer.is_stopped():
			$hurt_timer.start()
		else:
			return
#		set_collision_layer_bit(1, false)
#		set_collision_layer_bit(2, false)
		if !has_node("hoaming_shield"):
			$AudioStreamPlayer.play()
			Globals.hp -= 1
			Globals.current_scene.get_node("HUD").get_node("TextureProgress").value -= 1
			if area.is_in_group("enemy_bullet"):
				area.queue_free()
			$AnimationPlayer.play("hurt")
			if Globals.hp <= 0:
				Globals.lifes -= 1
				if Globals.lifes == 5:
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart5").visible = false
				if Globals.lifes == 4:
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart5").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart4").visible = false
				if Globals.lifes == 3:
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart5").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart4").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart3").visible = false
				if Globals.lifes == 2:
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart5").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart4").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart3").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart2").visible = false
				if Globals.lifes == 1:
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart5").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart4").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart3").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart2").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart1").visible = false
				if Globals.lifes == 0:
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart5").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart4").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart3").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart2").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart1").visible = false
					Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart0").visible = false
				if Globals.lifes == -1 && Globals.credits > 0:
					Globals.goto_scene("res://assets/stages/GameOverScreen.tscn")
				elif Globals.lifes == -1 && Globals.credits <= 0:
					Globals.goto_scene("res://assets/stages/TrueGameOverScreen.tscn")
				var explosion = EXPLOSION.instance()
				get_parent().add_child(explosion)
				explosion.position = $explosion_position.global_position
				explosion.emitting = true
				$AnimationPlayer.stop()
				$explosion.play()
				visible = false
				$explosion_timer.start()
				monitoring = false
				set_process(false)
#		else:
#			$AnimationPlayer.play("hurt")
#			get_tree().get_nodes_in_group("hoaming_item").front().queue_free()
#			area.set_damage(get_node("hoaming_shield").attack_power)
#			if get_node("hoaming_shield").get_child_count() == 2:
#				get_node("hoaming_shield").queue_free()

func _on_explosion_timer_timeout():
	monitoring = true
	$explosion_timer.stop()
	position = $spawn_position.position
	visible = true
	get_tree().get_nodes_in_group("HUD").front().get_node("TextureProgress").value = 4
	Globals.hp = 4
	set_process(true)
	for i in get_tree().get_nodes_in_group("explosion"):
		i.queue_free()

func _on_hurt_timer_timeout():
#	$hurt_timer.stop()
	set_collision_mask_bit(2, true)
	set_collision_layer_bit(0, true)
	monitoring = true


func _on_Spaceship_body_entered(body):
#		set_collision_mask_bit(0, false)
#		set_collision_mask_bit(1, false)
	$AudioStreamPlayer.play()
	set_collision_mask_bit(2, false)
	set_collision_layer_bit(0, false)
	$hurt_timer.start()
#		set_collision_layer_bit(1, false)
#		set_collision_layer_bit(2, false)
	if !has_node("hoaming_shield"):
		Globals.hp -= 1
		Globals.current_scene.get_node("HUD").get_node("TextureProgress").value -= 1
		if body.is_in_group("enemy_bullet"):
			body.queue_free()
		$AnimationPlayer.play("hurt")
		if Globals.hp <= 0:
			Globals.lifes -= 1
			if Globals.lifes == 5:
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart5").visible = false
			if Globals.lifes == 4:
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart5").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart4").visible = false
			if Globals.lifes == 3:
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart5").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart4").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart3").visible = false
			if Globals.lifes == 2:
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart5").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart4").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart3").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart2").visible = false
			if Globals.lifes == 1:
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart5").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart4").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart3").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart2").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart1").visible = false
			if Globals.lifes == 0:
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart5").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart4").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart3").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart2").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart1").visible = false
				Globals.current_scene.get_node("HUD").get_node("hearts").get_node("heart0").visible = false
			if Globals.lifes == -1 && Globals.credits >= 0:
				Globals.goto_scene("res://assets/stages/GameOverScreen.tscn")
			elif Globals.lifes == -1 && Globals.credits < 0:
				Globals.goto_scene("res://assets/stages/TrueGameOverScreen.tscn")
			var explosion = EXPLOSION.instance()
			get_parent().add_child(explosion)
			explosion.position = $explosion_position.global_position
			explosion.emitting = true
			$AnimationPlayer.stop()
			visible = false
			$explosion.play()
			$explosion_timer.start()
			monitoring = false
			set_process(false)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "finished_stage":
		Globals.goto_scene(nextScene)

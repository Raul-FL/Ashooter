extends Position2D

export var hp : int = 0
export var speed : int = 20
export var idle_speed : = 10
export var angle : float
export var angle_shoot : float = 20
export var dir_shot : bool = false
export var shot_type : = 1
export var shot_speed : = 40
export var shot_interval : = 4
export var initial_wait_time : = 1
export var rotate_with_angle : = false
export var wave_lenght : = 10
export var wave_speed : = 0.4
export var inverted : = false
export var shot_count : = 3
export var stage_clear : = false
export var final_stage : = false
export (PackedScene) var SHOT
export (PackedScene) var BULLET
export (PackedScene) var BEHAVIOR
export (PackedScene) var enemy

func _process(delta):
	
	var velocity = Vector2()
	velocity.x += 1
	velocity = velocity * -idle_speed
	position += velocity * delta
	
	if position.x < 160:
		var public_enemy = enemy.instance()
		public_enemy.angle = angle
		public_enemy.rotate_with_angle = rotate_with_angle
		public_enemy.speed = speed
		public_enemy.position = position
		if "hp" in public_enemy:
			if hp > 0:
				public_enemy.hp = hp
		if "stage_clear" in public_enemy:
			public_enemy.stage_clear = stage_clear
		if "final_stage" in public_enemy:
			public_enemy.final_stage = final_stage
		if BEHAVIOR:
			var behavior = BEHAVIOR.instance()
			behavior.wave_lenght = wave_lenght
			behavior.wave_speed = wave_speed
			behavior.inverted = inverted
			public_enemy.add_child(behavior)
		if SHOT:
			var shoot_type = SHOT.instance()
			shoot_type.start_wait_time = float(initial_wait_time)
			shoot_type.shot_type = shot_type
			if "shot_count" in shoot_type:
				shoot_type.shot_count = shot_count
			if "angle_gap" in shoot_type:
				shoot_type.angle_gap = angle_shoot
			if "angle" in shoot_type:
				shoot_type.angle = angle_shoot
			if "wait_time" in shoot_type:
				shoot_type.wait_time = shot_interval
			shoot_type.speed = shot_speed
			if "dir_shoot" in shoot_type:
				shoot_type.dir_shoot = dir_shot
			shoot_type.get_node("wait_timer").wait_time = shot_interval
			shoot_type.position = public_enemy.get_node("shot_pivot").position
			public_enemy.add_child(shoot_type)
			shoot_type.shoot = BULLET
		
		get_parent().add_child(public_enemy)
		queue_free()
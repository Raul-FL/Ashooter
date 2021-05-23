extends Node2D

export (int) var speed = 100
export (int) var attack_power = 1

func _ready():
	set_process(false)

func _process(delta):
	var velocity0 = Vector2()
	var velocity1 = Vector2()
	var velocity2 = Vector2()
	var velocity3 = Vector2()
	
	velocity0.x += 1
	velocity0.y += -0.6
	velocity0 = velocity0 * speed
	
	$fireball0.position += velocity0 * delta
	
	velocity1.x += 1
	velocity1.y += -0.2
	velocity1 = velocity1 * speed
	
	$fireball1.position += velocity1 * delta
	
	velocity2.x += 1
	velocity2.y += 0.2
	velocity2 = velocity2 * speed
	
	$fireball2.position += velocity2 * delta
	
	velocity3.x += 1
	velocity3.y += 0.6
	velocity3 = velocity3 * speed
	
	$fireball3.position += velocity3 * delta


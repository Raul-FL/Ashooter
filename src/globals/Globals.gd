extends Node

var max_hp : = 4
var hp : = 4
var initial_hp : = 4
var max_lifes = 6
var lifes = 2
var initial_lifes = 2
var max_score = 9999
var score = 0
var credits = 3

var max_lazer : = 6
var max_area_attack = 6
var max_missile = 9
var max_hoaming_shield = 3
var max_mass_attack = 1

var lazer : = 2
var initial_lazer : = 2
var area_attack : = 1
var missile : = 4
var initial_missile : = 4
var hoaming_shield = 0
var mass_attack = 1
var initial_mass_attack : = 1

var current_scene = null

var stage : = 0

func reset_stats():
	lifes = initial_lifes
	hp = initial_hp
	missile = initial_missile
	lazer = initial_lazer
	mass_attack = initial_mass_attack

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)

func goto_scene(path):
    call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	current_scene.free()
	if typeof(path) == TYPE_STRING:
		var s = ResourceLoader.load(path)
		current_scene = s.instance()
	else:
		current_scene = path.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
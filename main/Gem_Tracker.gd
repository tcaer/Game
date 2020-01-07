extends Node

var random_num_g = RandomNumberGenerator.new()

onready var gem_scene = preload('res://entities/Gem_Entity.tscn')
onready var player_instance = get_parent().get_node('Player')

const MAX_GEM_DISTANCE = 1000
const MAX_GEMS_IN_WORLD = 100
var gems_in_world = 0

func _process(delta):
	handle_gems()
	
func handle_gems():
	var player_position = player_instance.position
	
	while gems_in_world < MAX_GEMS_IN_WORLD:
		var rand_x = random_num_g.randf_range(player_position.x - MAX_GEM_DISTANCE, player_position.x + MAX_GEM_DISTANCE)
		var rand_y = random_num_g.randf_range(player_position.y - MAX_GEM_DISTANCE, player_position.y + MAX_GEM_DISTANCE)
		
		var gem = gem_scene.instance()
		gem.position = Vector2(rand_x, rand_y)
		
		gems_in_world += 1
		get_parent().add_child(gem)
		
func decrease_num_gems(gem):
	gems_in_world -= 1
	gem.queue_free()
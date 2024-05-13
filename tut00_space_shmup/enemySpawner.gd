extends Node2D

# spawn new enemy every interval

# Note: @export exposes a variable to the godot editor
# Note: PackedScene is how to accept tscn's 
@export var enemy_tscn : PackedScene

const SPAWN_Y = -50
const SPAWN_X = 80

# Tied to timeout()
# --> Timer > Node > timeout() > Pick > spawn_enemy_ship()
func spawn_enemy_ship():
	var new_enemy = enemy_tscn.instantiate()
	
	add_child(new_enemy)
	new_enemy.position.y = SPAWN_Y
	var rand_x = randf_range(get_viewport_rect().position.x + SPAWN_X, get_viewport_rect().size.x - SPAWN_X);
	new_enemy.position.x = rand_x


class_name Player
extends Node2D

@export var stats: CharacterStats : set = set_character_stats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var stats_ui: StatsUI = $StatsUI as StatsUI
@onready var health_bar: HealthBar = $HealthBar as HealthBar

func _ready() -> void:
	return
	#HARDCODED DAMAGE AN BLOCK VALUES 
	await get_tree().create_timer(4).timeout
	take_damage(20)
	stats.block += 17

## The below code requires setup() to be called in battle.tscn
#var stats: CharacterStats
#func setup(new_stats: CharacterStats) -> void:
	#stats = new_stats
	
## this is the alternative --> Allows the scene to be tested independently
func set_character_stats(value: CharacterStats) -> void:
	stats = value
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
	
	update_player()

func update_player() -> void:
	if not stats is CharacterStats: return
	if not is_inside_tree(): await ready	
	sprite_2d.texture = stats.art
	update_stats()

func update_stats() -> void:
	#stats_ui.update_stats(stats)
	health_bar.update_stats(stats)
	

func take_damage(damage: int) -> void:
	if stats.health <= 0: return 
	stats.take_damage(damage)
	
	# Deletes player from the scene (game over)
	if stats.health <= 0:
		queue_free()

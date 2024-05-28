class_name Enemy
extends Area2D

const CURSOR_OFFSET := 6

@export var stats: Stats : set = set_enemy_stats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var cursor: Sprite2D = $Cursor
@onready var stats_ui: StatsUI = $StatsUI
@onready var health_bar: HealthBar = $HealthBar

func _ready() -> void:
	return
	#HARDCODED DAMAGE AN BLOCK VALUES
	await get_tree().create_timer(2).timeout
	take_damage(6)
	stats.block += 8

func set_enemy_stats(value: Stats) -> void:
	stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
	
	update_enemy()

func update_enemy() -> void:
	if not stats is Stats: return
	if not is_inside_tree(): await ready	
	sprite_2d.texture = stats.art
	cursor.position = Vector2.UP * (sprite_2d.get_rect().size.y / 2 + CURSOR_OFFSET)
	update_stats()

func update_stats() -> void:
	#stats_ui.update_stats(stats)
	health_bar.update_stats(stats)

func take_damage(damage: int) -> void:
	if stats.health <= 0: return 
	
	stats.take_damage(damage)
	
	# Deletes enemy from the scene
	if stats.health <= 0:
		queue_free()


func _on_area_entered(_area: Area2D):
	cursor.show()


func _on_area_exited(_area: Area2D):
	cursor.hide()
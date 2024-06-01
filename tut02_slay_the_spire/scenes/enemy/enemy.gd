class_name Enemy
extends Area2D

const CURSOR_OFFSET := 6

# add a new texture for damage effects
const WHITE_SPRITE_MATERIAL := preload("res://art/white_sprite_material.tres")


@export var stats: EnemyStats : set = set_enemy_stats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var cursor: Sprite2D = $Cursor
@onready var stats_ui: StatsUI = $StatsUI
@onready var health_bar: HealthBar = $HealthBar
@onready var intent_ui: IntentUI = $IntentUI

var enemy_action_picker: EnemyActionPicker
var current_action: EnemyAction : set = set_current_action

func set_current_action(value: EnemyAction) -> void:
	current_action = value
	
	# update intents when setting an action
	if current_action:
		intent_ui.update_intent(current_action.intent)

func set_enemy_stats(value: EnemyStats) -> void:
	stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		stats.stats_changed.connect(update_action)
	
	update_enemy()

func setup_ai() -> void:
	if enemy_action_picker: enemy_action_picker.queue_free()
	
	var new_action_picker: EnemyActionPicker = stats.ai.instantiate()
	add_child(new_action_picker)
	enemy_action_picker = new_action_picker
	enemy_action_picker.enemy = self

func update_action() -> void:
	if not enemy_action_picker: return
	if not current_action:
		current_action = enemy_action_picker.get_action()
	
	# allows the enemy to react to the player
	var new_conditional_action := enemy_action_picker.get_first_conditional_action()
	if new_conditional_action and current_action != new_conditional_action:
		current_action = new_conditional_action

func update_enemy() -> void:
	if not stats is Stats: return
	if not is_inside_tree(): await ready
	sprite_2d.texture = stats.art
	cursor.position = Vector2.UP * (sprite_2d.get_rect().size.y / 2 + CURSOR_OFFSET)
	setup_ai()
	update_stats()

# MAIN FUNCTION
func do_turn() -> void: 
	stats.block = 0
	if not current_action: return
	current_action.perform_action()

func update_stats() -> void:
	#stats_ui.update_stats(stats)
	health_bar.update_stats(stats)

func take_damage(damage: int) -> void:
	if stats.health <= 0: return 
	
	# white damage effect
	sprite_2d.material = WHITE_SPRITE_MATERIAL
	
	var tween := create_tween()
	tween.tween_callback(Shaker.shake.bind(self, 16, 0.15))
	tween.tween_callback(stats.take_damage.bind(damage))
	tween.tween_interval(0.18)
	tween.finished.connect(
		func(): 
			sprite_2d.material = null
			if stats.health <= 0: 
				self.queue_free()
	)
	

func _on_area_entered(_area: Area2D):
	cursor.show()

func _on_area_exited(_area: Area2D):
	cursor.hide()

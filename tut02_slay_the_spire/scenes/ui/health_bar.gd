class_name HealthBar
extends Control

@export var stats: Stats

@onready var health_progress_bar : TextureProgressBar = %HealthProgressBar
@onready var health_label: Label = %HealthLabel
@onready var block_progress_bar : TextureProgressBar = %BlockProgressBar
@onready var block_icon: TextureRect = %BlockIcon
@onready var block_label: Label = %BlockLabel

func update_stats(stats: Stats):
	health_progress_bar.value = stats.health * 100 / stats.max_health
	health_label.text = str(stats.health)
	
	if stats.block > 0:
		health_progress_bar.value = block_progress_bar.value
		block_progress_bar.visible = true
		block_icon.visible = true
		block_label.visible = true
		block_label.text = str(stats.block)
	else:
		block_progress_bar.visible = false
		block_label.visible = false
		block_icon.visible = false

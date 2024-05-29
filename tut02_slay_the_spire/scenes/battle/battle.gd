extends Node2D

# MAIN and ONLY PLACE where the character stats is provided in the project
@export var char_stats: CharacterStats

@onready var battle_ui: BattleUI = $BattleUI as BattleUI
@onready var player_handler: PlayerHandler = $PlayerHandler as PlayerHandler
@onready var player = $Player

func _ready() -> void:
	# normally, we would reset stats on a "run" function
	# this way, we can keep health, gold, and deck between battles
	var new_stats: CharacterStats = char_stats.create_instance()
	battle_ui.char_stats = new_stats
	player.stats = new_stats
	
	Events.player_turn_ended.connect(player_handler.end_turn)
	Events.player_hand_discarded.connect(player_handler.start_turn)
	
	start_battle(new_stats)  

func start_battle(stats: CharacterStats) -> void:
	player_handler.start_battle(stats)

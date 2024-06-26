extends EnemyAction

@export var block := 15
@export var hp_threshold := 6

# Conditional Action
var already_used := false
func is_performable() -> bool:
	if not enemy or already_used:
		return false
	var is_low := enemy.stats.health <= hp_threshold
	already_used = is_low
	return is_low

func perform_action() -> void:
	if not enemy: return
	
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.execute([enemy]) # execute takes in an array of nodes as a parameter
	
	# wait for the enemy to block
	get_tree().create_timer(0.6, false).timeout.connect(
		func(): Events.enemy_action_completed.emit(enemy)
	)

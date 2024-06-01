extends EnemyAction

@export var block := 6

# this is a random action
func perform_action() -> void:
	if not enemy: return
	
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	block_effect.execute([enemy]) # execute takes in an array of nodes as a parameter
	
	# wait for the enemy to block
	get_tree().create_timer(0.6, false).timeout.connect(
		func(): Events.enemy_action_completed.emit(enemy)
	)

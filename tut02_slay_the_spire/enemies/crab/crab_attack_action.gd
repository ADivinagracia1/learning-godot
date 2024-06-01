extends EnemyAction

@export var damage := 7

# this is a random action
func perform_action() -> void:
	if not enemy or not target: return
	
	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	var start_pos := enemy.global_position
	var end_pos := target.global_position + Vector2.RIGHT * 32
	var damage_effect := DamageEffect.new()
	var target_array: Array[Node] = [target]
	damage_effect.amount = damage
	
	# perform animation
	tween.tween_property(enemy.sprite_2d, "global_position", end_pos, 0.4)
	tween.tween_callback(damage_effect.execute.bind(target_array))
	tween.tween_interval(0.25)
	tween.tween_property(enemy.sprite_2d, "global_position", start_pos, 0.4)
	tween.finished.connect(
		func(): Events.enemy_action_completed.emit(enemy)
	)

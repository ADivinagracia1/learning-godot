extends CardState

func enter() -> void:
	# children get ready first. card_ui (parent) is only ready when all children are ready 
	if not card_ui.is_node_ready():
		await card_ui.ready
	
	# fixes the quick return to hand bug
	if card_ui.tween and card_ui.tween.is_running():
		card_ui.tween.kill()
	
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
	card_ui.reparent_requested.emit(card_ui)
	card_ui.pivot_offset = Vector2.ZERO # holds center of card instead of topleft

#var inty = 0
func on_gui_input(event: InputEvent) -> void:
	if card_ui.disabled or not card_ui.playable: return # dragging and base events
	if event.is_action_pressed("left_mouse"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.State.CLICKED)

func on_mouse_entered() -> void:
	if card_ui.disabled or not card_ui.playable: return # dragging and base events
	card_ui.panel.set("theme_override_styles/panel", card_ui.HOVER_STYLEBOX)
	
	
func on_mouse_exited() -> void:
	if card_ui.disabled or not card_ui.playable: return # dragging and base events
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)

extends CardState

var played: bool

func enter() -> void:
	#card_ui.color.color = Color.DARK_VIOLET
	#card_ui.state.text = "RELEASED"
	played = false
	
	# Play card
	if not card_ui.targets.is_empty():
		played = true
		card_ui.play()
		Events.tooltip_hide_requested.emit() # hide tooltip when playing

func on_input(_event: InputEvent):
	if played: return
	
	# state change to base state
	transition_requested.emit(self, CardState.State.BASE)

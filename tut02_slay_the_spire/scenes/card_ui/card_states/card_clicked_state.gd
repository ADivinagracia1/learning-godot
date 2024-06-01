extends CardState

func enter() -> void:
	#card_ui.color.color = Color.ORANGE
	#card_ui.state.text = "CLICKED"
	card_ui.drop_point_detector.monitoring = true
	card_ui.original_index = card_ui.get_index()
	
# read any kind of input (mouse motion)
func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING)



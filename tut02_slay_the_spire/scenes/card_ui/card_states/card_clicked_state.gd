extends CardState

func enter() -> void:
	print("here1")
	card_ui.color.color = Color.ORANGE
	print("here2")	
	card_ui.state.text = "CLICKED"
	print("here3")	
	card_ui.drop_point_detector.monitoring = true
	print("here4")
	

# read any kind of input (mouse motion)
func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING)

extends CardState

# Time Delay for card clicking debounce
const DRAG_MINIMUM_THRESHOLD := 0.05
var minimum_drag_time_elapsed := false

func enter() -> void:
	# reparent the card to the BattleUI
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
	
	card_ui.color.color = Color.NAVY_BLUE
	card_ui.state.text = "DRAGGING"
	
	# Enable debounce drag timer
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)

func on_input(event: InputEvent) -> void:
	var single_targeted := card_ui.card.is_single_targeted() # function we made
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	# check to go to aiming state
	if single_targeted and mouse_motion and card_ui.targets.size() > 0:
		transition_requested.emit(self, CardState.State.AIMING)
		return
	
	# card being dragged around 
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
		
	if cancel:
		transition_requested.emit(self, CardState.State.BASE)		# return card to hand
	elif minimum_drag_time_elapsed and confirm: # debounce drag time elapsed applied
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)	# play the card


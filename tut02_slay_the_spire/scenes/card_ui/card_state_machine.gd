class_name CardStateMachine
extends Node2D

@export var initial_state: CardState

var current_state: CardState
var states := {}

func init(card: CardUI) -> void:
	print("here0")
	for child in get_children():
		if child is CardState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.card_ui = card
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _on_transition_requested(from: CardState, to: CardState.State):
	# `from` and `current_state` has to be the same
	if from != current_state: return
	
	# `to` must be in the enum of states
	var new_state: CardState = states[to]
	if not new_state: return
		
	# exit the current state
	if current_state:
		current_state.exit()
		
	# enter the new state after all the checks
	new_state.enter()
	current_state = new_state

# Callback Functions for user Inputs
func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)

func on_gui_input(event: InputEvent) -> void:
	if current_state:
		print(str(current_state))
		current_state.on_gui_input(event)

func on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()
		
func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()
		


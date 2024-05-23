class_name CardUI
extends Control

signal reparent_requested(which_card_ui: CardUI)

# Chidren of CardUI
@onready var color: ColorRect = $Color
@onready var state: Label = $State
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine

func _ready() -> void:
	card_state_machine.init(self)

# NOTE: LOOK UP WHY WE USE CALLBACKS FOR THESE INPUT FUNCTIONS

func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)

# THE BELOW FUNCTIONS NEED TO BE CONNECTED TO THE PROPER SIGNAL SCRIPT

func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)
	
func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()

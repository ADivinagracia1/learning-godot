class_name Hand
extends HBoxContainer

@export var char_stats: CharacterStats

# load nonexistant cards into the hand so that the hand expects children of type Card
@onready var card_ui := preload("res://scenes/card_ui/card_ui.tscn")

func add_card(card: Card) -> void:
	var new_card_ui := card_ui.instantiate()
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	new_card_ui.card = card
	new_card_ui.parent = self
	new_card_ui.char_stats = char_stats

func discard_card(card: CardUI) -> void:
	card.queue_free()

func disable_hand() -> void:
	for card in get_children():
		card.disabled = true

# Returns card to hand
func _on_card_ui_reparent_requested(child: CardUI):
	child.disabled = true # for strange bug
	
	child.reparent(self)
	# makes sure the order of the cards remains consisten when a card returns to hand
	var new_index := clampi(child.original_index, 0, get_child_count())
	move_child.call_deferred(child, new_index) #makes sure this happens at the end of frame
	
	child.set_deferred("disabled", false) # for strange bug

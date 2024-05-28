class_name Hand
extends HBoxContainer

var cards_played_this_turn := 0

func _ready():
	Events.card_played.connect(_on_card_played)
	
	for child in get_children():
		var card_ui := child as CardUI
		card_ui.parent = self
		card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)

# Returns card to hand
func _on_card_ui_reparent_requested(child: CardUI):
	child.reparent(self)
	
	# makes sure the order of the cards remains consisten when a card returns to hand
	var new_index := clampi(child.original_index - cards_played_this_turn, 0, get_child_count())
	move_child.call_deferred(child, new_index) #makes sure this happens at the end of frame

func _on_card_played(_card: Card) -> void:
	cards_played_this_turn += 1

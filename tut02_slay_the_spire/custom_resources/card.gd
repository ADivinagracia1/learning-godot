class_name Card
extends Resource

enum Type {ATTACK, SKILL, POWER}
enum Target {SELF, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE}

@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var target: Target 
@export var cost: int

@export_group("Card Visuals")
@export var icon: Texture
@export_multiline var tooltip_text: String
@export var sound: AudioStream

func is_single_targeted() -> bool:
	return target == Target.SINGLE_ENEMY

# function only calls when its not a single target card
func _get_targets(targets: Array[Node]) -> Array[Node]:
	if not targets: return []
	
	var tree := targets[0].get_tree()
	
	# match is switch-case
	match target:
		Target.SELF:
			return tree.get_nodes_in_group("player")
		Target.ALL_ENEMIES:
			return tree.get_nodes_in_group("enemies")
		Target.EVERYONE:
			return tree.get_nodes_in_group("player") + tree.get_nodes_in_group("enemies")
		_:
			return []

func play(targets: Array[Node], char_stats: CharacterStats) -> void:
	Events.card_played.emit(self)
	char_stats.mana -= cost
	
	if is_single_targeted():
		apply_effects(targets)					# single target cards
	else:
		apply_effects(_get_targets(targets))	# non single target cards


func apply_effects(_targets: Array[Node]) -> void:
	print("effecs not applied")
	pass

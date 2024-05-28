extends Node2D

const ARC_POINTS := 10

# Children of CardTargetSelector
@onready var area_2d: Area2D = $Area2D
@onready var card_arc: Line2D = $CanvasLayer/CardArc

var current_card: CardUI
var targeting := false

func _ready() -> void:
	Events.card_aim_started.connect(_on_card_aim_started)
	Events.card_aim_ended.connect(_on_card_aim_ended)

func _process(_delta: float) -> void:
	if not targeting: return
	
	area_2d.position = get_local_mouse_position()
	card_arc.points = _get_points()
	 
	
func _get_points() -> Array:
	var points := []
	var start := current_card.global_position
	start.x += (current_card.size.x / 2) # card arc starts from the middle of the card
	var target := get_local_mouse_position()
	var distance := target - start
	
	#print("start: ", start, start.x)
	#print("current_card size: ", current_card.size.x)
	#print("disance: ", distance)
	
	for i in range(ARC_POINTS):
		var t:= (1.0 / ARC_POINTS) * i
		var x = start.x + (distance.x /ARC_POINTS) * i
		var y = start.y + ease_out_cubic(t) * distance.y
		points.append(Vector2(x,y))
		
	points.append(target)
	
	return points

func ease_out_cubic(number: float) -> float:
	return 1.0 - pow(1.0 - number, 3.0) # plot this on desmos (trinomial)

func _on_card_aim_started(card: CardUI) -> void:
	if not card.card.is_single_targeted():
		return
	
	# Enable card arc targeting and visuals
	targeting = true
	area_2d.monitoring = true
	area_2d.monitorable = true
	current_card = card

func _on_card_aim_ended(card: CardUI):
	# Clear children values
	card_arc.clear_points()
	area_2d.position = Vector2.ZERO
	current_card = null
	
	# Disable card arc targeting and visuals	
	targeting = false
	area_2d.monitoring = false
	area_2d.monitorable = false
	

# Selecting and deselecting an Enemy
func _on_area_2d_area_entered(area: Area2D) -> void:
	if not current_card or not targeting: return
	
	# entering a valid target area
	if not current_card.targets.has(area):
		current_card.targets.append(area)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if not current_card or not targeting: return
	current_card.targets.erase(area)

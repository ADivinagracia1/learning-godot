class_name Tooltip
extends PanelContainer

@export var fade_secods := 0.2

@onready var tooltip_icon: TextureRect = %TooltipIcon
@onready var tooltip_text_label: RichTextLabel = %TooltipText

var tween: Tween
var is_visibe := false

func _ready() -> void:
	# connect tooltip functions to the Event signals
	Events.card_tooltip_requested.connect(show_tooltip)
	Events.tooltip_hide_requested.connect(hide_tooltip)
	
	# hide tooltip initially
	modulate = Color.TRANSPARENT
	hide()

func show_tooltip(icon: Texture, text: String) -> void:
	# note that functions are called every tick depending on how its used
	# when the animation is happening, we stop the new animation
	is_visibe = true
	if tween: tween.kill()
	
	tooltip_icon.texture = icon
	tooltip_text_label.text = text
	
	# fade in (tween) tooltip
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(show)
	tween.tween_property(self, "modulate", Color.WHITE, fade_secods)

func hide_tooltip() -> void:
	is_visibe = false
	if tween: tween.kill()
	
	# call hide animation 
	# but with a little delay so the tooltip doesnt flicker hovering between cards
	get_tree().create_timer(fade_secods, false).timeout.connect(hide_animation)


func hide_animation() -> void:
	if not is_visibe:
		# fade out tooltip
		tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "modulate", Color.TRANSPARENT, fade_secods)
		tween.tween_callback(hide)

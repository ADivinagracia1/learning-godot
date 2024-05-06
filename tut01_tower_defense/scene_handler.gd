extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	#get_node("MainMenu/M/VB/NewGame").connect("pressed", self, "on_new_game_pressed")
	#get_node("MainMenu/M/VB/NewGame").connect("pressed", on_new_game_pressed())
	get_node("MainMenu/M/VB/Quit").connect("pressed", on_quit_pressed())

func on_new_game_pressed():
	pass

func on_quit_pressed():
	get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

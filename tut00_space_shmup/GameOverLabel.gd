extends Label

func _process(delta):
	if GameState.is_game_over == true:
		self.visible = true

	if Input.is_action_just_pressed("ui_accept") and GameState.is_game_over:
		print("enter pressed")
		
		# reload scene
		get_tree().reload_current_scene()
		GameState.reset_valeus()

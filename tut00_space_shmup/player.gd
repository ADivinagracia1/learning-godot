extends Node2D

@export var laser_tscn : PackedScene

# Player node must move to mouse position all the time
func _process(delta):
	#print("x: %d\ty: %d" % [self.position.x, self.position.y])
	var mouse_pos = get_global_mouse_position()
	self.position.x = mouse_pos.x
	
		# Player clicks --> Spawn Laser
	# - Project > Project Settings > Input Map
	if Input.is_action_just_pressed("shoot"):
		var new_laser = laser_tscn.instantiate()
		add_sibling(new_laser)
		new_laser.position = self.position
		print("PEW!")

func _on_area_entered(area):
	# if enemy enters, player di es
	if area.is_in_group("enemy"):
		self.queue_free()
		GameState.is_game_over = true

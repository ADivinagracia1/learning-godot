extends Node2D

@export var speed : float = 150

func _process(delta):
	self.position.y += speed * delta

# area_entered on ?itself?
# NOTE: The "area" parameter is any new area that comes into this enemy area
func _on_area_entered(area):
	self.queue_free()
	# area.queue_free() # Allows us to comment out _on_area_entered() in both player.gd and laser.gd
	print("enemy destroyed")
	GameState.increase_score(100)
	print("Score: ", GameState.score)

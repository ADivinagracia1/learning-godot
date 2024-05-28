extends Node2D

# Makes it available in the editor
@export var speed : float = 1000 # pixels per second

func _process(delta):
	# as laser spawns, position changes
	self.position.y -= speed * delta

# function that destroyes the laser
func _on_area_entered(other_area):
	# if it hit an ENEMY (not it any area)
	# otherwise, Hits ANY area, laser deletes
	if other_area.is_in_group("enemy"):
		self.queue_free()

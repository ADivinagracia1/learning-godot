extends Node2D

# Makes it available in the editor
@export var speed : float = 1000 # pixels per second

func _process(delta):
	# as laser spawns, position changes
	self.position.y -= speed * delta

func _on_area_entered(area):
	self.queue_free()

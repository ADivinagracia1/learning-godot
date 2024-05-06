extends Node2D

@export var speed : float = 150

func _process(delta):
	self.position.y += speed * delta

# area_entered on ?itself?
func _on_area_entered(area):
	self.queue_free()
	print("enemy destroyed")

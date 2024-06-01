class_name Effect
extends RefCounted

var sound: AudioStream

# All effects have to be executed, all cards will inherit from this
func execute(_targets: Array[Node]) -> void:
	pass

extends AudioStreamPlayer

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS

func _on_finished() -> void:
	play()

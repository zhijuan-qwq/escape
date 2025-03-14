extends Teleporter

@export var gate :AnimatedSprite2D

func _ready() -> void:
	gate.play("idle")

func _on_interacted() -> void:
	gate.play("open")

func _on_exited() -> void:
	gate.play("close")

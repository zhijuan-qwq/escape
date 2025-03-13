extends Area2D

@export var gate :AnimatedSprite2D

func _ready() -> void:
	gate.play("idle")

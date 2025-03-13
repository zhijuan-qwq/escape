extends Area2D

@export var player :CharacterBody2D

func _on_body_entered(_body: Node2D) -> void:
	player.died()

class_name Level
extends Node

@onready var player: CharacterBody2D = $player
@onready var camera_2d: Camera2D = $player/Camera2D

func update_player(pos:Vector2) -> void:
	player.global_position = pos
	camera_2d.reset_smoothing()
	camera_2d.force_update_scroll()
	

class_name Interactable
extends Area2D

signal interacted
signal exited

func _init():
	collision_layer = 0
	set_collision_mask_value(1,true)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func interact() -> void:
	interacted.emit()

func exit() -> void:
	exited.emit()

func _on_body_entered(player:Node2D) -> void:
	if not player is CharacterBody2D:
		return
	player.interacting_with = self
	interact()

func _on_body_exited(player:Node2D) -> void:
	if not player is CharacterBody2D:
		return
	player.interacting_with = null
	exit()

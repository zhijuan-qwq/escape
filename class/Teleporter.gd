class_name Teleporter
extends Interactable

@export_file("*.tscn") var path: String
@export var entry_point: String
var can_teleport: bool = true

func teleport() -> void:
	Game.change_scene.call_deferred(path,entry_point)

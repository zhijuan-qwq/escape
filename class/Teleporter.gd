class_name Teleporter
extends Interactable

@export_file("*.tscn") var path: String
@export var entry_point: String

func teleport() -> void:
	Global.change_scene.call_deferred(path,entry_point)

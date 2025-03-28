extends Control

@export var BGM :AudioStream

func _ready() -> void:
	SoundManager.play_bgm(BGM)


func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/UI/title_screen.tscn")

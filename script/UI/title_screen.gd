extends Control

@export var BGM :AudioStream

func _ready() -> void:
	SoundManager.play_bgm(BGM)

#临时
func _on_new_game_pressed() -> void:
	Game.change_scene("res://scene/level/level1/level1_1.tscn","entrance")


func _on_exit_game_pressed() -> void:
	get_tree().quit()


func _on_about_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/UI/about.tscn")

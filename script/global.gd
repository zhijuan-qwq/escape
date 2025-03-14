extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

const FADE_TIME:float = 1.0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("F11"):
		var mode = DisplayServer.window_get_mode()
		if mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if event.is_action_pressed("Esc"):
		var mode = DisplayServer.window_get_mode()
		if mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func change_scene(path:String,entry_point:String) -> void:
	var tree := get_tree()
	
	var tween := create_tween()
	tween.tween_property(color_rect,"color:a",1,FADE_TIME)
	await tween.finished
	
	tree.change_scene_to_file(path)
	await tree.tree_changed
	for node in tree.get_nodes_in_group("entry_points"):
		if node.name == entry_point:
			tree.current_scene.update_player(node.global_position)
			break
	
	tween = create_tween()
	tween.tween_property(color_rect,"color:a",0,FADE_TIME)

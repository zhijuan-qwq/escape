extends Node

''
@export var sfx :Node
@export var bgm :AudioStreamPlayer

#获取SFX节点中对应名称的AudioStreamPlayer播放音效
func play_sfx(name :String) -> void:
	var player = sfx.gat_node(name) as AudioStreamPlayer
	if not player:
		return
	player.play()
#播放BGM
func play_bgm(stream :AudioStream) -> void:
	if bgm.stream == stream and bgm.playing:
		return
	bgm.stream = stream
	bgm.play()
#链接场景节点中的button的信号
#func setup_ui_sounds(node: Node) -> void:
	#var button := node as Button
	#if button:
		#button.pressed.connect(play_sfx.bind(""))
		#button.focus_entered.connect(play_sfx.bind(""))
	#
	#for child in node.get_children():
		#setup_ui_sounds(child)

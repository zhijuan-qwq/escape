extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Esc") or event.is_action_pressed("next dialog"):
		animation_player.speed_scale = 2.0

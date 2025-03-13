extends StaticBody2D

@export var anima :AnimationPlayer

func _on_area_2d_area_entered(_area: Area2D) -> void:
	anima.play("Break it apart")
	

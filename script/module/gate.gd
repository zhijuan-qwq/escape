extends Teleporter

@onready var gate: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var locking :bool = false

func _ready() -> void:
	if locking:
		gate.play("idle_lock")
		collision.disabled = true
	else:
		gate.play("idle")
		collision.disabled = false
	
func open_lock() -> void:
	gate.play("open_lock")
	await gate.animation_finished
	collision.disabled = false
	gate.play("idle")

func _on_interacted() -> void:
	gate.play("open")

func _on_exited() -> void:
	gate.play_backwards("open")

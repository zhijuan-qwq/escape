extends CharacterBody2D

@export var tile_map :TileMapLayer

@onready var animated: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_timer: Timer = $CoyoteTimer
@onready var jump_request_timer: Timer = $JumpRequestTimer
@onready var camera_2d: Camera2D = $Camera2D
@onready var entrance: EntryPoint = $"../entrance"

const SPEED = 180.0
const JUMP_VELOCITY = -300.0

var was_on_floor
var should_jump
var direction
var interacting_with: Interactable

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		jump_request_timer.start()
		
	if event.is_action_released("jump"):
		jump_request_timer.stop()
		if velocity.y < JUMP_VELOCITY * 0.45:
			velocity.y = JUMP_VELOCITY * 0.45
	
	if event.is_action_pressed("interact") and interacting_with:
		if interacting_with is Teleporter and interacting_with.can_teleport:
			interacting_with.teleport()
		
#设置相机可以移动范围
func _ready() -> void: 
	if tile_map is TileMapLayer:
		var used := tile_map.get_used_rect();
		var tile_size := tile_map.tile_set.tile_size;
		 
		if used.end.x * tile_size.x >= 17 && used.position.y * tile_size.y >= 30:
			camera_2d.enabled = false
		else:
			camera_2d.enabled = true
			camera_2d.limit_smoothed = true
		
		camera_2d.limit_top = used.position.y * tile_size.y;
		camera_2d.limit_right = used.end.x * tile_size.x;
		camera_2d.limit_bottom = used.end.y * tile_size.y;
		camera_2d.limit_left = used.position.x * tile_size.x
		camera_2d.reset_smoothing()
		
func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity += get_gravity() * delta
		
	var can_jump := is_on_floor() or coyote_timer.time_left > 0
	should_jump = can_jump && jump_request_timer.time_left > 0
	if  should_jump:
		velocity.y = JUMP_VELOCITY
		coyote_timer.stop()
		jump_request_timer.stop()
	
	direction = Input.get_axis("left", "right")
	if direction:
		animated.flip_h = direction < 0
		velocity.x = direction * SPEED
	else:
		velocity.x *= 0.4
	
	was_on_floor = is_on_floor()
	move_and_slide()
	get_next_state()
	if is_on_floor() != was_on_floor:
		if was_on_floor && !should_jump:
			coyote_timer.start()
		else: 
			coyote_timer.stop()
	
#状态控制与切换
func get_next_state():
	if !is_on_floor():
		if abs(velocity.y) < 65:
			animated.play("steady")
			return
		elif velocity.y < 0:
			if abs(velocity.x) < 5:animated.play("vertical_jump")
			else:animated.play("jump")
		elif velocity.y > 350:
			if abs(velocity.x) < 5:animated.play("vertical_fall!")
			else:animated.play("fall!")
		elif velocity.y > 280:
			if abs(velocity.x) < 5:animated.play("vertical_excessive")
			else:animated.play("fall_excessive")
		else:
			if abs(velocity.x) < 5:animated.play("vertical_fall")
			else:animated.play("fall")
	else:
		if (is_on_floor() != was_on_floor) && !(was_on_floor && !should_jump):
			animated.play("fall")
			animated.frame = 1
			return
		if direction && is_on_wall():
			animated.play("push")
			return
		if abs(velocity.x) > 10:
			animated.play("run")
		else:
			animated.play("idle")

func die() -> void:
	velocity = Vector2(0,0)
	position = entrance.global_position

func _on_area_2d_body_entered(_body: Node2D) -> void:
	die()

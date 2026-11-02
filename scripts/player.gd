extends CharacterBody3D
## Feet are the origin; the capsule and camera are offset above them.

@export var movement_speed: float = 3.5
@export var mouse_sensitivity: float = 0.002
const PITCH_LIMIT: float = deg_to_rad(85.0)
@onready var camera: Camera3D = $Camera
var spawn_position: Vector3
var controls_active: bool = false
var window_focused: bool = true
var discard_next_motion: bool = false


func _ready() -> void:
	spawn_position = position


func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		window_focused = false
		release_controls()
	elif what == NOTIFICATION_APPLICATION_FOCUS_IN:
		window_focused = true


func release_controls() -> void:
	controls_active = false
	discard_next_motion = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	velocity.x = 0.0
	velocity.z = 0.0
	for action: StringName in [&"move_forward", &"move_backward", &"move_left", &"move_right"]:
		Input.action_release(action)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		release_controls()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and window_focused and not controls_active:
		controls_active = true
		discard_next_motion = true
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event is InputEventMouseMotion and controls_active:
		# Cursor recentering can produce a synthetic relative-motion event.
		if discard_next_motion:
			discard_next_motion = false
			return
		rotate_y(-event.screen_relative.x * mouse_sensitivity)
		camera.rotation.x = clampf(camera.rotation.x - event.screen_relative.y * mouse_sensitivity, -PITCH_LIMIT, PITCH_LIMIT)


func _physics_process(delta: float) -> void:
	var input_direction := Vector2.ZERO
	if controls_active:
		input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := basis * Vector3(input_direction.x, 0.0, input_direction.y)
	velocity.x = direction.x * movement_speed
	velocity.z = direction.z * movement_speed
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	# The temporary test platform has open edges; keep the preview recoverable.
	if position.y < -10.0:
		position = spawn_position
		velocity = Vector3.ZERO

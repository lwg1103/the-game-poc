extends CharacterBody3D
## Feet are the origin; the capsule and camera are offset above them.

@export var movement_speed: float = 3.5
@export var mouse_sensitivity: float = 0.002
const PITCH_LIMIT: float = deg_to_rad(85.0)
@onready var camera: Camera3D = $Camera
var spawn_position: Vector3
var controls_active: bool = false


func _ready() -> void:
	spawn_position = position


func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		controls_active = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		controls_active = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		controls_active = true
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event is InputEventMouseMotion and controls_active:
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

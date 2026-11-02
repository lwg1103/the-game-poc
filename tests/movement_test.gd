extends SceneTree


func _initialize() -> void:
	call_deferred("run_test")


func run_test() -> void:
	var world := (load("res://scenes/main.tscn") as PackedScene).instantiate()
	root.add_child(world)
	var player := world.get_node("Player") as CharacterBody3D
	await create_timer(0.2, true, true).timeout
	var click := InputEventMouseButton.new()
	click.button_index = MOUSE_BUTTON_LEFT
	click.pressed = true
	player._unhandled_input(click)
	var start := player.position
	Input.action_press("move_forward")
	await create_timer(0.2, true, true).timeout
	Input.action_release("move_forward")
	if player.position.z >= start.z - 0.1:
		fail("Forward input must move the player.")
		return
	var straight_speed := Vector2(player.velocity.x, player.velocity.z).length()
	Input.action_press("move_forward")
	Input.action_press("move_right")
	await create_timer(0.1, true, true).timeout
	Input.action_release("move_forward")
	Input.action_release("move_right")
	if absf(Vector2(player.velocity.x, player.velocity.z).length() - straight_speed) > 0.01:
		fail("Diagonal movement must not increase speed.")
		return
	var motion := InputEventMouseMotion.new()
	motion.screen_relative = Vector2(100, 100000)
	player._unhandled_input(motion)
	var camera := player.get_node("Camera") as Camera3D
	if player.rotation.y >= 0 or absf(camera.rotation.x) > deg_to_rad(85.01) or camera.rotation.x >= 0:
		fail("Mouse look must turn right, look down and clamp pitch.")
		return
	player.rotation.y = PI / 2.0
	Input.action_press("move_forward")
	await create_timer(0.1, true, true).timeout
	Input.action_release("move_forward")
	if player.velocity.x >= -0.1 or absf(player.velocity.z) > 0.01:
		fail("Movement must follow yaw without following camera pitch.")
		return
	var escape := InputEventAction.new()
	escape.action = &"pause"
	escape.pressed = true
	player._unhandled_input(escape)
	var yaw := player.rotation.y
	player._unhandled_input(motion)
	Input.action_press("move_forward")
	await create_timer(0.1, true, true).timeout
	Input.action_release("move_forward")
	if player.rotation.y != yaw or Vector2(player.velocity.x, player.velocity.z).length() > 0.01:
		fail("Released cursor must stop movement and mouse look.")
		return
	print("PASS: Movement, diagonal speed, yaw direction, pitch clamp and released cursor.")
	quit(0)


func fail(message: String) -> void:
	push_error(message)
	quit(1)

extends SceneTree


func _initialize() -> void:
	call_deferred("run_test")


func run_test() -> void:
	var player := (load("res://scenes/player.tscn") as PackedScene).instantiate()
	root.add_child(player)
	var click := InputEventMouseButton.new()
	click.button_index = MOUSE_BUTTON_LEFT
	click.pressed = true
	player._unhandled_input(click)
	Input.action_press("move_forward")
	player.velocity = Vector3(1, -2, 1)
	player._notification(Node.NOTIFICATION_APPLICATION_FOCUS_OUT)
	if player.controls_active or Input.is_action_pressed("move_forward") or player.velocity.x != 0 or player.velocity.z != 0:
		fail("Focus loss must release controls, stale actions and horizontal velocity.")
		return
	player._unhandled_input(click)
	if player.controls_active:
		fail("An unfocused window must not capture controls.")
		return
	player._notification(Node.NOTIFICATION_APPLICATION_FOCUS_IN)
	if player.controls_active:
		fail("Focus gain must wait for an explicit click.")
		return
	player._unhandled_input(click)
	var motion := InputEventMouseMotion.new()
	motion.screen_relative = Vector2(500, 300)
	player._unhandled_input(motion)
	if player.rotation.y != 0 or player.get_node("Camera").rotation.x != 0:
		fail("The first captured motion must not jump the camera.")
		return
	player._unhandled_input(motion)
	if player.rotation.y == 0:
		fail("Subsequent captured motion must rotate the camera.")
		return
	var escape := InputEventAction.new()
	escape.action = &"pause"
	escape.pressed = true
	player._unhandled_input(escape)
	if player.controls_active or Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		fail("Escape must release the cursor.")
		return
	print("PASS: Focus loss, explicit recapture, camera jump guard and Escape.")
	quit(0)


func fail(message: String) -> void:
	push_error(message)
	quit(1)

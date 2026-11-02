extends SceneTree


func _initialize() -> void:
	call_deferred("run_test")


func run_test() -> void:
	var scene := load("res://scenes/main.tscn") as PackedScene
	var world := scene.instantiate()
	root.add_child(world)
	var player := world.get_node_or_null("Player") as CharacterBody3D
	if player == null:
		fail("The main scene must contain a character body.")
		return
	player.position.y = 0.8
	await create_timer(0.2, true, true).timeout
	if player.position.y >= 0.8 or player.velocity.y >= 0.0:
		fail("Gravity must move an airborne player downwards.")
		return
	await create_timer(1.5, true, true).timeout
	if not player.is_on_floor() or absf(player.position.y) > 0.01:
		fail("The player must land with feet at floor level.")
		return
	var landed_y := player.position.y
	await create_timer(0.5, true, true).timeout
	if absf(player.position.y - landed_y) > 0.001:
		fail("The grounded player must remain stable.")
		return
	var camera := root.get_camera_3d()
	if camera == null or not player.is_ancestor_of(camera) or absf(camera.global_position.y - 1.65) > 0.01:
		fail("The active camera must follow the player at eye height.")
		return
	print("PASS: Gravity, landing, grounded stability and eye-height camera.")
	quit(0)


func fail(message: String) -> void:
	push_error(message)
	quit(1)

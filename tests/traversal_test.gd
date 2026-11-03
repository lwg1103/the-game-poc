extends SceneTree
## Drives the production controller through the apartment at physics-frame cadence.

var player: CharacterBody3D
var failure: String = ""
const ACTIONS: Array[StringName] = [&"move_left", &"move_right", &"move_forward", &"move_backward"]


func _initialize() -> void:
	call_deferred("run_test")


func run_test() -> void:
	var world := (load("res://scenes/main.tscn") as PackedScene).instantiate()
	root.add_child(world)
	player = world.get_node("Player")
	if "--disable-walls" in OS.get_cmdline_user_args():
		# Negative control: prove the wall checks detect missing collision geometry.
		for wall: Node in world.get_node("Apartment/Walls").get_children():
			wall.get_node("Body").collision_layer = 0
	await physics_frame
	player.controls_active = true
	# Each doorway is traversed in both directions, including a return to spawn.
	var route: Array[Vector2] = [
		Vector2(0.8, 1), Vector2(-1.2, 1), Vector2(-3, -2),
		Vector2(-1.2, 1), Vector2(0.8, 1), Vector2(0.8, -2),
		Vector2(2.2, -2), Vector2(2.2, -1), Vector2(2.2, -2),
		Vector2(0.8, -2), Vector2(0.8, 2), Vector2(3, 2),
		Vector2(3, 3), Vector2(2.3, 2), Vector2(0.8, 2), Vector2(0.8, 3)
	]
	for target: Vector2 in route:
		if not await walk_to(target):
			finish(false)
			return
	release_actions()
	# Push into the hallway west wall while moving north: slide, do not stick.
	player.position = Vector3(0.8, 0.01, -1)
	player.velocity = Vector3.ZERO
	set_direction(Vector2(-1, -1).normalized())
	for frame: int in range(40):
		await physics_frame
	if player.position.x < 0.37 or player.position.z > -2.1:
		failure = "Wall contact must preserve sliding and prevent penetration."
		finish(false)
		return
	# Keep pushing into the closed northwest hallway corner.
	for frame: int in range(100):
		await physics_frame
	if player.position.x < 0.37 or player.position.z < -3.61 or not player.is_on_floor():
		failure = "Corner pressure must not escape the apartment or lose the floor."
		finish(false)
		return
	if not await walk_to(Vector2(0.8, -2)):
		finish(false)
		return
	# Isolate structural corners; furniture occupies some of these test origins.
	for body: Node in get_nodes_in_group("furniture_collision"):
		body.collision_layer = 0
	# Test all four outer corners, then walk away without resetting the body.
	for corner: Vector2 in [Vector2(-1, -1), Vector2(-1, 1), Vector2(1, -1), Vector2(1, 1)]:
		var start := Vector2(corner.x * 4, corner.y * 3)
		player.position = Vector3(start.x, 0.01, start.y)
		player.velocity = Vector3.ZERO
		set_direction(corner.normalized())
		for frame: int in range(100):
			await physics_frame
		if absf(player.position.x) > 4.61 or absf(player.position.z) > 3.61 or not player.is_on_floor():
			failure = "Outer corner must contain the player: " + str(corner)
			finish(false)
			return
		if not await walk_to(start):
			finish(false)
			return
	finish(true)


func walk_to(target: Vector2) -> bool:
	for frame: int in range(300):
		var offset := target - Vector2(player.position.x, player.position.z)
		if offset.length() < 0.09:
			release_actions()
			return true
		set_direction(offset.normalized())
		await physics_frame
		if player.position.y < -0.05 or player.position.y > 0.1:
			failure = "Traversal must remain on the floor."
			return false
	failure = "Unable to reach route waypoint: " + str(target)
	return false


func set_direction(direction: Vector2) -> void:
	release_actions()
	Input.action_press("move_left", maxf(-direction.x, 0))
	Input.action_press("move_right", maxf(direction.x, 0))
	Input.action_press("move_forward", maxf(-direction.y, 0))
	Input.action_press("move_backward", maxf(direction.y, 0))


func release_actions() -> void:
	for action: StringName in ACTIONS:
		Input.action_release(action)


func finish(passed: bool) -> void:
	release_actions()
	if passed:
		print("PASS: Full apartment route, bidirectional doorways, wall sliding and corner escape.")
	else:
		push_error(failure)
	quit(0 if passed else 1)

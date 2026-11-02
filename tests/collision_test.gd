extends SceneTree


func _initialize() -> void:
	call_deferred("run_test")


func run_test() -> void:
	var world := (load("res://scenes/main.tscn") as PackedScene).instantiate()
	root.add_child(world)
	var player := world.get_node("Player") as CharacterBody3D
	player.set_physics_process(false)
	await physics_frame
	await physics_frame
	var spawn := player.transform
	if player.test_move(spawn, Vector3(0, 0.01, 0)):
		fail("Spawn must not overlap apartment geometry.")
		return
	for probe: Array in [
		[Vector3(0.8, 0.01, 3), Vector3(-1.5, 0, 0)],
		[Vector3(0.8, 0.01, -3), Vector3(0, 0, -2)],
		[Vector3(0.8, 0.01, 3), Vector3(0, 0, 2)],
		[Vector3(-4, 0.01, 0), Vector3(-2, 0, 0)],
		[Vector3(4, 0.01, -1), Vector3(2, 0, 0)],
		[Vector3(3, 0.01, -1), Vector3(0, 0, 2)],
		[Vector3(0.8, 0.01, 0), Vector3(0, -1, 0)]
	]:
		if not player.test_move(Transform3D(Basis.IDENTITY, probe[0]), probe[1]):
			fail("A wall or floor must block the player: " + str(probe))
			return
	for doorway: Array in [
		[Vector3(0.8, 0.01, 1), Vector3(-1.6, 0, 0)],
		[Vector3(0.8, 0.01, -2), Vector3(1.6, 0, 0)],
		[Vector3(0.8, 0.01, 2), Vector3(1.6, 0, 0)]
	]:
		if player.test_move(Transform3D(Basis.IDENTITY, doorway[0]), doorway[1]):
			fail("The full player capsule must fit through each doorway.")
			return
	print("PASS: Spawn clearance, wall/floor blocking and three capsule-width doorways.")
	quit(0)


func fail(message: String) -> void:
	push_error(message)
	quit(1)

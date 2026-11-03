extends SceneTree

func _initialize() -> void:
	call_deferred("run_test")

func run_test() -> void:
	var player := (load("res://scenes/player.tscn") as PackedScene).instantiate() as CharacterBody3D
	root.add_child(player)
	player.set_physics_process(false)
	for model: String in ["sofa", "table", "bed", "kitchen", "vanity", "shower"]:
		var furniture := (load("res://assets/models/" + model + ".tscn") as PackedScene).instantiate()
		root.add_child(furniture)
		await physics_frame
		await physics_frame
		if not player.test_move(Transform3D(Basis.IDENTITY, Vector3(-3, 0.01, 0)), Vector3(6, 0, 0)):
			push_error("Furniture must block the player: " + model)
			quit(1)
			return
		furniture.free()
	print("PASS: All six furniture models block the player capsule.")
	quit(0)

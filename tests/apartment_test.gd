extends SceneTree


func _initialize() -> void:
	var world := (load("res://scenes/main.tscn") as PackedScene).instantiate()
	root.add_child(world)
	var apartment := world.get_node_or_null("Apartment")
	if apartment == null:
		push_error("The main scene must contain the apartment blockout.")
		quit(1)
		return
	for room: String in ["LivingKitchen", "Bedroom", "Bathroom", "Hallway"]:
		if apartment.get_node_or_null(room) == null:
			push_error("Missing room: " + room)
			quit(1)
			return
	print("PASS: Apartment blockout contains all four room zones.")
	quit(0)

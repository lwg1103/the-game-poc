extends SceneTree

func _initialize() -> void:
	var trial := (load("res://tools/lightmap_trial.tscn") as PackedScene).instantiate()
	var gi := trial.get_node("LightmapGI") as LightmapGI
	if gi.light_data == null:
		push_error("The LightmapGI trial must contain baked light data.")
		quit(1)
		return
	for name: String in ["Floor", "Furniture"]:
		var mesh: Mesh = trial.get_node(name).mesh
		if mesh.surface_get_arrays(0)[Mesh.ARRAY_TEX_UV2].is_empty():
			push_error("Static bake geometry must have UV2.")
			quit(1)
			return
	trial.free()
	for path: String in ["res://licenses/GODOT_LICENSE.txt", "res://licenses/GODOT_COPYRIGHT.txt", "res://licenses/ASSET_SOURCES.txt"]:
		if not FileAccess.file_exists(path):
			push_error("Missing redistribution notice: " + path)
			quit(1)
			return
	print("PASS: Baked trial, UV2 and redistribution notices.")
	quit(0)

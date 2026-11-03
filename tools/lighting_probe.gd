extends SceneTree

func _initialize() -> void:
	var mesh := BoxMesh.new()
	mesh.add_uv2 = true
	print("UV2 vertices: ", mesh.surface_get_arrays(0)[Mesh.ARRAY_TEX_UV2].size())
	var gi := LightmapGI.new()
	for method: Dictionary in gi.get_method_list():
		if "bake" in method.name:
			print(method)
	gi.free()
	quit()

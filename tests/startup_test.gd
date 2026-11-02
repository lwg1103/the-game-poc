extends SceneTree


func _initialize() -> void:
	var scene_path: String = ProjectSettings.get_setting("application/run/main_scene", "")
	if scene_path.is_empty():
		push_error("A startup scene must be configured.")
		quit(1)
		return
	var scene := load(scene_path) as PackedScene
	if scene == null:
		push_error("The startup scene must load.")
		quit(1)
		return
	var instance := scene.instantiate()
	root.add_child(instance)
	await process_frame
	if not instance is Node3D or root.get_camera_3d() == null:
		push_error("The startup scene must provide a 3D world and active camera.")
		quit(1)
		return
	print("PASS: Startup scene loads with an active 3D camera.")
	quit(0)

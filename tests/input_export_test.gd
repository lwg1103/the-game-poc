extends SceneTree


func _initialize() -> void:
	var bindings := {"move_forward": KEY_W, "move_backward": KEY_S, "move_left": KEY_A, "move_right": KEY_D, "pause": KEY_ESCAPE}
	for action: String in bindings:
		var event := InputEventKey.new()
		event.physical_keycode = bindings[action]
		if not InputMap.has_action(action) or not InputMap.action_has_event(action, event):
			push_error("Missing physical key binding: " + action)
			quit(1)
			return
	var preset := ConfigFile.new()
	if preset.load("res://export_presets.cfg") != OK or preset.get_value("preset.0", "platform", "") != "Windows Desktop" or preset.get_value("preset.0.options", "binary_format/architecture", "") != "x86_64":
		push_error("A Windows x64 export preset is required.")
		quit(1)
		return
	print("PASS: Physical input bindings and Windows x64 export preset.")
	quit(0)

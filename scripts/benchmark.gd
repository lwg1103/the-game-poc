extends Node
## Opt-in release-build measurement; normal play has no per-frame benchmark work.
var samples: Array[float] = []
var frames: int = 0
var previous: int

func _ready() -> void:
	set_process("--benchmark" in OS.get_cmdline_user_args())
	if not is_processing():
		return
	DisplayServer.window_set_size(Vector2i(1920, 1080))
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	Engine.max_fps = 0
	var player := get_parent().get_node("Player")
	player.set_physics_process(false)
	player.position = Vector3(-0.8, 0, 2.8)
	player.rotation.y = 0.6
	player.get_node("Camera").rotation.x = -0.15
	previous = Time.get_ticks_usec()

func _process(_delta: float) -> void:
	var now := Time.get_ticks_usec()
	var elapsed := float(now - previous) / 1000.0
	previous = now
	frames += 1
	if frames > 240:
		samples.append(elapsed)
	if samples.size() == 1200:
		var total := 0.0
		for value: float in samples:
			total += value
		samples.sort()
		var report := {"gpu": RenderingServer.get_video_adapter_name(), "resolution": DisplayServer.window_get_size(), "frames": samples.size(), "mean_ms": total / samples.size(), "average_fps": 1000.0 * samples.size() / total, "p99_ms": samples[1188], "worst_ms": samples[-1], "draw_calls": Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)}
		var output := "user://benchmark.json"
		for argument: String in OS.get_cmdline_user_args():
			if argument.begins_with("--report="):
				output = argument.trim_prefix("--report=")
		FileAccess.open(output, FileAccess.WRITE).store_string(JSON.stringify(report, "\t"))
		print(report)
		get_tree().quit()

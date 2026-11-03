# Lighting and performance (T12–T15)

Lighting uses four warm downward spot lamps with shadows and one cool daylight spot at a window panel. Each light has a bounded range; a disabled directional sun no longer spends a shadow pass on the closed apartment. SSAO provides contact shading, filmic tonemapping uses exposure 1.0, and colour ambient light keeps unlit surfaces readable. The window is a luminous visual panel, not an opening with outdoor geometry.

## LightmapGI evaluation

All apartment and furniture BoxMesh resources now request UV2. `tools/lighting_probe.gd` confirms 24 UV2 vertices on a box in the pinned 4.7.2 engine. LightmapGI requires static GI geometry, suitable UV2, and an editor bake. Its bake operation is not exposed by this build's runtime scripting API. An editor bake of tools/lightmap_trial.tscn succeeded on RTX 3060, producing lightmap_trial.exr and lightmap_trial.lmbake (including probes). The saved trial scene and outputs are included for reproduction; this is a capability test, not a bake-quality comparison of the full apartment.

Decision for this iteration: retain dynamic lighting because the measured room cost is low and the layout is still being refined. UV2 preparation is retained for a future editor bake. The player has no visible mesh, so dynamic-object lightmap probes are currently unnecessary; moving visible objects receive real-time lights. The small static-scene bake is verified. Baking the entire apartment is optional follow-up work under the retained dynamic-lighting decision.

Reference: https://docs.godotengine.org/en/stable/classes/class_lightmapgi.html

## Measurement

Windows release build, Godot 4.7.2 Forward+, RTX 3060, Intel Core i5-10400. 1920×1080 window, VSync disabled for measurement, static furnished living/kitchen camera. 240 warm-up frames and 1200 measured frames. Raw data: `benchmark-t15.json`.

Final result: average 601.89 FPS, mean 1.661 ms, p99 2.394 ms, worst 2.752 ms, 47 reported draw calls. These are end-to-end frame intervals, not isolated GPU timings or 1% low FPS. The short fixed-view sample is not a full-route performance guarantee; background application load was not controlled. T19 provides broader profiling.

Reproduce: `ApartmentFPP-T15.exe -- --benchmark --report=C:/path/report.json`. Normal play retains its usual window and VSync configuration. The benchmark node disables its processing unless explicitly requested.

Validation: startup and full traversal tests passed. Living/kitchen render inspected on the actual GPU. License files are included in exports; F1 opens engine and asset credits. No ray tracing, SDFGI or real-time reflection rendering was added.

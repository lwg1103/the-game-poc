# Traversal verification (T09)

Run with the pinned Godot 4.7.2 engine:

```powershell
Godot_v4.7.2-stable_win64_console.exe --headless --fixed-fps 60 --path . --script tests/traversal_test.gd
```

The test drives the production player's physics controller through input actions. It visits the living/kitchen zone, bedroom and bathroom, crosses each doorway in both directions and returns to the hallway spawn. It verifies floor height, wall sliding, sustained pressure into a hallway corner and all four outer corners, and walking away after corner contact. Route waypoints have a bounded timeout to detect blocked movement.

Results: passed with simulated render rates of 30, 60 and 144 FPS (default 60 Hz physics). These are deterministic traversal checks, not GPU performance measurements. All seven earlier test scripts also passed. No geometry or controller corrections were needed.

Negative control: append `-- --disable-walls`. This disables wall collision layers only within the test instance; the test correctly exits with code 1 at the wall-contact check.

Manual review in the running build: walk from the hallway into every room and back, hold diagonally into walls/corners, then move away. Check the centered crosshair, reduced mouse sensitivity, Escape and Alt+Tab. Automated checks do not replace this visual/input review.

Furniture remains a visual placeholder without collision until T11. Repeat traversal verification when furniture collisions or the layout change.

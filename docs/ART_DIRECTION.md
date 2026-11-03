# Interior materials and models (T10)

Direction: warm contemporary interior in simplified realism. Use muted sage upholstery/cabinet accents, warm oak, neutral linen, pale ceramic, grey stone and dark hardware. Shared StandardMaterial3D resources live in `assets/materials/`; roughness distinguishes fabric, ceramic and worktops without texture downloads.

Six reusable native Godot model scenes live in `assets/models/`: sofa, table, bed, kitchen, vanity and shower. Geometry is authored for this repository from primitive meshes; no external models or textures were downloaded. All dimensions are metres and each model origin is at floor level. Materials and component names are shared consistently for further refinement.

Models replace the matching blockout objects in the apartment for visual review. Furniture collision and final placement validation remain T11. Room labels and preview lights remain temporary; lighting refinement is T13–T14.

Validation: Godot import and existing traversal test passed; a Forward+ screenshot of the living/kitchen area was inspected on RTX 3060. Materials currently use flat colours; detailed surface textures and photorealistic shading are outside this first pass.

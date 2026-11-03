# Furniture collision (T11)

All six reusable models now include static box collision. Sofa, table, bed, kitchen and vanity use conservative bounding boxes; the shower uses separate tray and back-panel boxes. Small hardware is omitted to keep contact predictable. The table's space beneath the top is blocked because the player cannot crouch.

Existing placement leaves room entrances clear. The bedroom traversal now follows the aisle beside the bed rather than crossing its footprint. Furniture collision is active for the full room route and hallway wall-contact tests. The legacy four outer-corner checks temporarily disable furniture only within their test instance because their starting points overlap the bed, kitchen and shower; they continue testing the structural shell separately.

Validation: the furniture test failed before implementation and now verifies capsule blocking for each model. The full apartment route passes with furniture collision enabled. No production collision is disabled by the test fixture.

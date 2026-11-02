# Apartment blockout (T07)

All dimensions use metres. Footprint: 10 × 8 m, clear ceiling height: 2.8 m. Wall thickness: 0.15 m internally, 0.2 m externally. Dimensions below are layout zones, not net usable areas.

| Zone | X bounds | Z bounds | Size |
|---|---|---|---|
| Living room + kitchen | -5 to 0 | -4 to 4 | 5 × 8 m |
| Hallway | 0 to 1.6 | -4 to 4 | 1.6 × 8 m |
| Bedroom | 1.6 to 5 | -4 to 0 | 3.4 × 4 m |
| Bathroom | 1.6 to 5 | 0 to 4 | 3.4 × 4 m |

Player starts at (0.8, 0.05, 3), looking north (-Z). Living-room opening: 1.4 m wide at Z=1. Bedroom and bathroom openings: 1.2 m wide at Z=-2 and Z=2. All openings are 2.2 m high.

```text
                 NORTH (-Z)
  +----------------+----+-----------+
  | kitchen        |    | bedroom   |
  |                |    :           |
  | living room    |hall+-----------+
  |                :    : bathroom  |
  | sofa + table   | P  |           |
  +----------------+----+-----------+
                 SOUTH (+Z)
```

Coloured floors, labels and primitive furniture communicate scale and function. Preview lights are temporary. T08 adds matching box colliders to all walls, lintels and ceiling; the floor collider is retained. Capsule sweeps verify all three doorways and a clear spawn. Hallway clear width is 1.45 m; doorways are 1.2/1.4 m wide and 2.2 m high for a 0.6 m wide, 1.8 m tall player. Furniture remains visual blockout until T11. T09 verifies full traversal and corners, T10–T11 replace placeholders with finished assets.

extends CharacterBody3D
## Feet are the origin; the capsule and camera are offset above them.


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

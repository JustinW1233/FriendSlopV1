extends RigidBody3D

func on_interact() -> void:
	print_debug("Mail picked up!")
	queue_free() # deletes self

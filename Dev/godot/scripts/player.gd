extends CharacterBody3D

const SPEED = 15.0
const JUMP_VELOCITY = 4.5
@onready var head: Node3D = %Head
@onready var mesh_instance_3d: MeshInstance3D = %MeshInstance3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("game_left", "game_right", "game_up", "game_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized().rotated(Vector3.UP, head.rotation.y)
	if direction:
		mesh_instance_3d.rotation.y = head.rotation.y
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

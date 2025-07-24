extends Area3D

# list of things in front of player to interact with
@export var in_range_interactables: Array[Node] = []

func _physics_process(delta: float) -> void:
	# Handle interaction.
	if Input.is_action_just_pressed("interact") && len(in_range_interactables) > 0:
		var interactableObject = in_range_interactables[0].get_parent()
		if len(in_range_interactables) > 1:
			var parent_global_position: Vector3 = get_parent_node_3d().global_position
			# unsafe code but basically we sort by distance to find closest, unsafe because assume parent of a and b is Node3D
			in_range_interactables.sort_custom(func(a: Node, b: Node): return true if a.get_parent().global_position.distance_to(parent_global_position) < b.get_parent().global_position.distance_to(parent_global_position) else false)
			interactableObject = in_range_interactables[0].get_parent()
		interactableObject.on_interact()

# when entering view, we will check if it has an interactable controller, if so add it to the list and connect to it
func _on_body_entered(body: Node3D) -> void:
	var interactionController: Node = body.find_child('InteractionController')
	if (interactionController):
		in_range_interactables.append(interactionController)
		interactionController.connect("remove_interactable", remove_interactable)

# when exiting view, we will check if it has an interactable controller, if so run remove_interactable
func _on_body_exited(body: Node) -> void:
	var interactionController: Node = body.find_child('InteractionController')
	if (interactionController):
		remove_interactable(interactionController)

# separate public function so that it can be used here and the interactable controller signal
func remove_interactable(interactionController: Node) -> void:
	if (interactionController in in_range_interactables):
		in_range_interactables.erase(interactionController)
		interactionController.disconnect("remove_interactable", remove_interactable)

extends Node

signal remove_interactable(body: Node)

func _ready() -> void:
	if (!get_parent().has_method("on_interact")):
		print_debug("WARNING: " + get_parent().name + "@" + get_parent().get_path().get_concatenated_names() + " missing method 'on_interact'")

func _notification(what: int) -> void:
	match what: # probably the most confusing line of code I'll ever write in my life
		NOTIFICATION_PREDELETE:
			on_predelete()

func on_predelete() -> void:
	# Remove self from all player interaction lists before being deleted.
	remove_interactable.emit(self)

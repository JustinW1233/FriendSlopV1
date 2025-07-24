extends Node3D

var using_mouse : bool = true
var mouse_sensitivity : float = 0.003
@onready var neck: Node3D = %Neck

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if using_mouse:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	_mouse_motion(event)
	_mouse_capture_and_release(event) # allow using ui_cancel button to move mouse outside of game window and clicking back into game to return focus

func _mouse_motion(event):
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return
	
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		neck.rotate_x(-event.relative.y * mouse_sensitivity)
		neck.rotation.x = clampf(neck.rotation.x, -deg_to_rad(75), deg_to_rad(90))

func _mouse_capture_and_release(event):
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("mouse1"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

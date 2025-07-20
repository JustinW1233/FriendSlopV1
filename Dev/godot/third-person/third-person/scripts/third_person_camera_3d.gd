extends Node3D

var distance_from_subject : int = 5
var using_mouse : bool = true
var mouse_sensitivity : float = 0.003
@onready var camera_3d: Camera3D = %Camera3D
@onready var pivot_x: Node3D = %PivotX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_3d.transform.origin.z = distance_from_subject
	if using_mouse:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	_mouse_motion(event)
	_mouse_capture_and_release(event)

func _mouse_motion(event):
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return
	
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		pivot_x.rotate_x(-event.relative.y * mouse_sensitivity)
		pivot_x.rotation.x = clampf(pivot_x.rotation.x, -deg_to_rad(75), deg_to_rad(90))

func _mouse_capture_and_release(event):
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("mouse1"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

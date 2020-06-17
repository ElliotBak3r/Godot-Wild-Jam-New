extends Node


signal input_direction(input_direction)
signal dash(direction)
signal pull(direction)

const UP = "ui_up"
const DOWN = "ui_down"
const LEFT = "ui_left"
const RIGHT = "ui_right"
const DASH = "ui_dash"
const PULL = "ui_pull"

var direction = Vector2(1,0)

func _get_direction(negative: String, positive: String) -> int:
	if(Input.is_action_pressed(positive)):
		return 1
	if(Input.is_action_pressed(negative)):
		return -1
	return 0
	

func _get_vertical_direction() -> int:
	return _get_direction(UP, DOWN)


func _get_horizontal_direction() -> int:
	return _get_direction(LEFT, RIGHT)	


func _get_input_direction() -> Vector2:
	var horizontal = _get_horizontal_direction()
	var vertical = _get_vertical_direction()
	return Vector2(horizontal, vertical)


func _handle_input_direction(delta:float): 
	var input_direction = _get_input_direction()
	if input_direction != Vector2.ZERO:
		emit_signal('input_direction', input_direction.normalized())
		if not Input.is_action_pressed(PULL):
			direction = input_direction.normalized()


func _handle_dash_input(event: InputEvent):
	var input_direction = _get_input_direction()
	if event.is_action_pressed(DASH) and input_direction != Vector2.ZERO:
		emit_signal('dash', input_direction)

func _handle_pull_input():
	if Input.is_action_pressed(PULL):
		emit_signal('pull', direction)

func _input(event): 
	_handle_dash_input(event)


func _physics_process(delta):
	_handle_pull_input()
	_handle_input_direction(delta)



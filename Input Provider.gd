extends Node


signal input_direction(input_direction)
const UP = "ui_up"
const DOWN = "ui_down"
const LEFT = "ui_left"
const RIGHT = "ui_right"

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


func _process(delta):
	var horizontal = _get_horizontal_direction()
	var vertical = _get_vertical_direction()
	if(horizontal == 0 and vertical == 0):
		return
	var input_direction = Vector2(horizontal, vertical).normalized()
	emit_signal('input_direction', input_direction * delta)


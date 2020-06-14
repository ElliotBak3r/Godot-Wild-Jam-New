extends KinematicBody2D


export(int) var top_speed = 250
export(int) var steps_to_reach_topspeed = 3
export(float) var drag_force = 0.25

const MAGIC_NUMBER = 60
#variables 
var acceleration = Vector2.ZERO
var velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	$InputProvider.connect('input_direction',self, "_on_input_direction")
	pass # Replace with function body.

func _on_input_direction(input_direction:Vector2):
	acceleration += input_direction

func _calculate_drag() -> Vector2:
	return velocity * drag_force 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var drag = _calculate_drag()
	velocity += (acceleration * top_speed / steps_to_reach_topspeed * MAGIC_NUMBER)
	velocity -= drag
	velocity = velocity.clamped(top_speed)
	velocity = move_and_slide(velocity)
	acceleration = Vector2.ZERO

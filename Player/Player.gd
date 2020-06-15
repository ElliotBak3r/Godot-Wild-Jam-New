extends KinematicBody2D


export(int) var top_speed = 250
export(int) var steps_to_reach_topspeed = 3
export(float) var drag_force = 0.25
export(bool) var dash_enabled = false

const DASH_FORCE = 0.25

const MAGIC_NUMBER = 60
#variables 
var acceleration = Vector2.ZERO
var velocity = Vector2.ZERO
var speed = top_speed / steps_to_reach_topspeed * MAGIC_NUMBER
# Called when the node enters the scene tree for the first time.

func _ready():
	var input_provider = $InputProvider
	input_provider.connect('input_direction',self, "_on_input_direction")
	input_provider.connect('dash',self,'_on_dash')


func _on_input_direction(input_direction:Vector2):
	acceleration += input_direction * speed


func _on_dash():
	if dash_enabled:
		acceleration += acceleration.normalized() * speed 


func _calculate_drag() -> Vector2:
	return velocity * drag_force 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity += acceleration - _calculate_drag()
	collision_layer = 1 if velocity.length() < top_speed*1.33 else 2
	collision_mask = collision_layer
	velocity = move_and_slide(velocity)
	acceleration = Vector2.ZERO
	
	

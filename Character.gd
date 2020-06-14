extends KinematicBody2D

var vel = Vector2(0,0)
var topspeed = 250

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Movement (Inputs for movements) -----------------------------------------
	if Input.is_action_pressed("ui_left"):
		vel.x -= topspeed/3 * 60 * delta
		# The 3 dividing the topspeed is the frames required to hit topspeed
	if Input.is_action_pressed("ui_right"):
		vel.x += topspeed/3 * 60 * delta
	if Input.is_action_pressed("ui_up"):
		vel.y -= topspeed/3 * 60 * delta
	if Input.is_action_pressed("ui_down"):
		vel.y += topspeed/3 * 60 * delta

	# Speed limit and stopping
	if vel.length_squared() > topspeed*topspeed:
		vel = vel.normalized() * topspeed
	if !Input.is_action_pressed("ui_left"):
		if !Input.is_action_pressed("ui_right"):
			vel.x /= 2
	if !Input.is_action_pressed("ui_up"):
		if !Input.is_action_pressed("ui_down"):
			vel.y /= 2

	#Post (after calculating everything) -----------------------------------------
	move_and_slide(vel)

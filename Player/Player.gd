extends KinematicBody2D


const TOP_SPEED = 750
const DRAG_FORCE = 50
const DASH_FORCE = 10000
const SPIRIT_SPEED = 20
const COLLISION_TYPES = {"ALL_COLLISION": 1, "DASH_OVER": 2}
const SPIRIT = preload("res://Spirit.tscn")
#references
onready var root = get_node("/root")
#variables 
var velocity = Vector2.ZERO


func _ready():
	var input_provider = $InputProvider
	input_provider.connect('input_direction',self, "_on_input_direction")
	input_provider.connect('dash',self,'_on_dash')
	input_provider.connect('possess',self,'_on_possess')


func _on_input_direction(input_direction:Vector2):
	velocity += input_direction * TOP_SPEED


func _on_dash(dash_direction:Vector2):
	velocity += dash_direction * DASH_FORCE
	_update_collision(COLLISION_TYPES["DASH_OVER"])

func _on_possess(spirit_direction:Vector2):
	var spirit = SPIRIT.instance()
	spirit.velocity = spirit_direction*SPIRIT_SPEED
	spirit.position = position
	root.add_child(spirit)


func _update_collision(collision: int):
	collision_layer = collision
	collision_mask = collision


func _get_drag() -> Vector2:
	return velocity / 2

func _is_not_dashing() -> bool:
	return velocity.length_squared() <= TOP_SPEED * TOP_SPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = move_and_slide(velocity - _get_drag(),Vector2.ZERO,false, 4, PI/4, false)
	if _is_not_dashing():
		_update_collision(COLLISION_TYPES["ALL_COLLISION"])
		
		for index in get_slide_count():
			var collision = get_slide_collision(index)
			if collision.collider.is_class("RigidBody2D"):
				collision.collider.apply_central_impulse(-collision.normal*1000)

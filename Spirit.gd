extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	position += velocity

func _on_Area2D_body_entered(body):
	queue_free()

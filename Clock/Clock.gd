extends Node


# Declare member variables here. Examples:
# var a = 2
onready var timer = get_node("Timer")
onready var clock_hand = get_node("Hand")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clock_hand.rotation = -timer.time_left/120 * TAU

func _on_Timer_timeout():
	get_tree().change_scene("res://World.tscn")

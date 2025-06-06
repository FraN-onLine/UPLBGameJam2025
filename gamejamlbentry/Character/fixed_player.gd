extends CharacterBody2D

class_name Player

signal healthChanged

@onready var healthbar: ProgressBar = $Healthbar
@export var speed: float = 200.0
@export var camera: Camera2D
var max_health = 200
var health = 200

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if input_vector.length() > 0:
		input_vector = input_vector.normalized() * speed
	else:
		input_vector = Vector2.ZERO

	velocity = input_vector
	move_and_slide()

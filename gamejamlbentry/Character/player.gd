extends Sprite2D

class_name Player

@export var speed: float = 200.0
@export var camera: Camera2D
var HP = 200

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
		position += input_vector * speed * delta

		# Sprite flipping logic for AnimatedSprite2D
		if input_vector.x != 0:
			$AnimatedSprite2D.flip_h = input_vector.x < 0

	# Camera following logic
	if camera:
		camera.position = position

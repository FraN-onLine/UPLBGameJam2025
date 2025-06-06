extends CharacterBody2D

class_name Player

signal healthChanged

@onready var healthbar: ProgressBar = $Healthbar
@export var speed: float = 200.0
@export var camera: Camera2D
var max_health = 100
var health = 100

func _ready():
	health = max_health
	healthbar.init_health(max_health)

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

	if input_vector.x != 0:
		$AnimatedSprite2D.flip_h = input_vector.x < 0
	
	var arrow = $Hand
	if arrow:
		var mouse_pos = get_global_mouse_position()
		var angle = (mouse_pos - global_position).angle()
		arrow.rotation = angle
		var radius = 3.5
		arrow.position = Vector2.RIGHT.rotated(angle) * radius

	if camera:
		camera.position = position

func take_damage(damage):
	health -= damage
	healthbar._set_health(health)
	emit_signal("healthChanged", health)
	if health <= 0:
		health = 0
		$AnimatedSprite2D.visible = false
		healthbar.visible = false
		print("Unit is dead!")
		self.queue_free()

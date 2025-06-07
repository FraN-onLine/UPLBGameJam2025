extends CharacterBody2D

class_name Player

signal healthChanged

@onready var healthbar: ProgressBar = $Healthbar
@onready var sword: Area2D = $Hand/Sword/Node2D/Sprite2D/Hitbox  # Adjust path as needed

@export var speed: float = 200.0
@export var camera: Camera2D

var max_health = 100
var health = 100

func _ready():
	health = max_health
	healthbar.init_health(max_health)
	if sword:
		sword.monitoring = false
	else:
		print("Sword node is null. Check instancing or load order.")


func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if input_vector.length() > 0:
		input_vector = input_vector.normalized() * speed
	else:
		input_vector = Vector2.ZERO

	velocity = input_vector
	move_and_slide()

	if input_vector.x != 0:
		$AnimatedSprite2D.flip_h = input_vector.x < 0

	# Aim the arm/hand toward mouse
	var arrow = $Hand
	if arrow:
		var mouse_pos = get_global_mouse_position()
		var angle = (mouse_pos - global_position).angle()
		arrow.rotation = angle
		var radius = 3.5
		arrow.position = Vector2.RIGHT.rotated(angle) * radius

	# Toggle sword monitoring on attack input
	if Input.is_action_just_pressed("basic_attack"):
		sword.monitoring = true
	elif Input.is_action_just_released("basic_attack"):
		sword.monitoring = false

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

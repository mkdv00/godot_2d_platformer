extends KinematicBody2D


export var gravity := 300
export var move_horizontal_speed := 120
export var jump_speed := 150

var _velocity := Vector2.ZERO
var _move_vector := Vector2.ZERO

onready var sprite: Sprite = $Sprite


func _process(delta: float) -> void:
	_velocity.y += gravity * delta
	_move_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	_move_vector.y = -1 if Input.is_action_pressed("jump") else 0
	
	if _move_vector.y < 0 and is_on_floor():
		_velocity.y = _move_vector.y * jump_speed
	
	_velocity.x = _move_vector.x * move_horizontal_speed
	_velocity = move_and_slide(_velocity, Vector2.UP)

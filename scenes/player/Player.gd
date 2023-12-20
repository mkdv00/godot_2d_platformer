extends KinematicBody2D


export var gravity := 1000.0
export var max_horizontal_speed := 135.0
export var horizontal_acceleration := 2000.0
export var jump_speed := 360.0
export var jump_termination_multiplier := 4

var _velocity := Vector2.ZERO


func _process(delta: float) -> void:
	# get movement vector
	var move_vector := get_movement_vector()
	
	# Accelerate horizontal movement
	_velocity.x += move_vector.x * horizontal_acceleration * delta
	# Deccelerate horizontal movement
	if move_vector.x == 0:
		_velocity.x = lerp(0, _velocity.x, pow(2, -50 * delta))
	
	# Clamp player speed
	_velocity.x = clamp(_velocity.x, -max_horizontal_speed, max_horizontal_speed)
	
	# Perform jump if 'jump' button pressed
	if move_vector.y < 0 and is_on_floor():
		_velocity.y = move_vector.y * jump_speed
	
	# Accelerate gravity
	if _velocity.y < 0 and not Input.is_action_pressed("jump"):
		_velocity.y += gravity * jump_termination_multiplier * delta
	else:
		_velocity.y += gravity * delta
	
	_velocity = move_and_slide(_velocity, Vector2.UP)


## Get movement vector from the player
func get_movement_vector() -> Vector2:
	var move_vector := Vector2.ZERO
	move_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_vector.y = -1 if Input.is_action_pressed("jump") else 0
	return move_vector

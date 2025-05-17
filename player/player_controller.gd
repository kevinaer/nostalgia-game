extends CharacterBody3D
class_name Player
@onready var animation_controller: PlayerAnimationStateMachine = %AnimationController
@onready var _model = %Skeleton

@export_group("Movement")
@export var speed := 5.0
@export var acceleration := 12.0
@export var deacceleration := 15.0
@export var rotation_speed := 12.0


var _last_movement_direction := Vector3.BACK

func _physics_process(delta: float) -> void:
	_move_character(delta)
	_rotate_character(delta)
	
func _move_character(delta: float) -> void:
	var raw_input := Input.get_vector("right", "left", "down", "up")
	var move_direction := Vector3(raw_input.x, 0, raw_input.y)
	move_direction = move_direction.normalized()
	if move_direction.length() == 0:
		velocity = velocity.move_toward(Vector3.ZERO, deacceleration * delta)
	else:
		velocity = velocity.move_toward(move_direction * speed, acceleration * delta)
	animation_controller.move(Vector2(velocity.x, velocity.z))
	move_and_slide()
	if move_direction.length() >= 0.2:
		_last_movement_direction = move_direction
		
func _rotate_character(delta: float) -> void:
	var movement_direction := _last_movement_direction
	var target_angle := Vector3.BACK.signed_angle_to(movement_direction, Vector3.UP)
	
	if abs(_model.rotation.y - target_angle) > 0.01:
		_model.rotation.y = lerp_angle(_model.rotation.y, target_angle, rotation_speed * delta)

	
	

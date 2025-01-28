extends CharacterBody3D

@export var target: Node3D
@export var force: Vector3
@export var acceleration:Vector3


@export var mass:float = 1
var max_speed = 10

func seek(target) -> Vector3:
	var toTarget:Vector3 = target.global_position - global_position
	var desired = toTarget.normalized() * max_speed
	
	return desired-velocity
	

func _ready()->void:
	pass
	
func _process(delta: float) -> void:
	force = seek(target)
	
	acceleration=force/mass
	
	velocity=(velocity+acceleration*delta)
	
	if velocity.length()>0:
		global_transform.basis.z=velocity.normalized()
	
	move_and_slide()
	
	pass

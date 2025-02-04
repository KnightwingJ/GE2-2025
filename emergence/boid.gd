extends CharacterBody3D

@export var target:Node3D
@export var force:Vector3
@export var accel:Vector3

@export var mass:float = 1
var max_speed = 10


@export var seek_enabled = false
@export var arrive_enabled = true

@export var arrive_targer:Node3D
@export var slowing_dist=10

func seek(target) -> Vector3:
	var to_target:Vector3 = target.global_position - global_position
	var desired = to_target.normalized() * max_speed
	return desired - velocity
	
	

func arrive(target)->Vector3:
	var to_target:Vector3=target.global_position - global_position
	var dist=to_target.length()
	var ramped=(dist/slowing_dist) * max_speed
	var clamped = min(ramped,max_speed)
	var desired = (to_target*clamped)/dist
	return desired - velocity
func _ready() -> void:
	pass
	
func draw_gizmos():
	DebugDraw3D.draw_arrow(global_position, global_position + force, Color.AQUAMARINE, 0.1)
	DebugDraw3D.draw_arrow(global_position, global_position + velocity, Color.CRIMSON, 0.1)
	DebugDraw3D.draw_sphere(arrive_targer.global_position,slowing_dist,Color.DARK_MAGENTA)
	
func calculate():
	var f:Vector3=Vector3.ZERO
	
	if seek_enabled:
		f+=seek(target)
	else:
		f+=arrive(arrive_targer)
	return f
func _process(delta: float) -> void:
	
	force = calculate()
	
	accel = force / mass
	
	velocity = (velocity + accel * delta)
	
	if velocity.length() > 0:
		
		look_at(global_position + velocity)
	
	move_and_slide()	
	
	draw_gizmos();
	
	pass

class_name LerpSmoothing
extends CameraControllerBase

@export var lead_speed: float
@export var catchup_delay_duration: float
@export var catchup_speed: float
@export var leash_distance: float

var _timer:Timer = null

func _ready() -> void:
	super()
	position = target.position
	
	#Taken from exercise 1
	if _timer == null:
		_timer = Timer.new()
		add_child(_timer)
		_timer.one_shot = true
	

func _process(delta: float) -> void:
	if !current:
		position = target.position
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	#if vessel and camera too far away
	var cam_to_target_dist: float = tpos.distance_to(cpos)
	if cam_to_target_dist > leash_distance:
		global_position += target.BASE_SPEED * (tpos - cpos).normalized() * delta * 15
		
	#if vessel is moving
	elif target.velocity != Vector3(0, 0, 0):
		global_position += tpos * delta * lead_speed
		_timer.start(catchup_delay_duration)
		
	#if vessel is not moving
	elif target.velocity == Vector3(0, 0, 0) and _timer.is_stopped():
		global_position += target.BASE_SPEED * (tpos - cpos).normalized() * catchup_speed * delta
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -5))
	
	immediate_mesh.surface_add_vertex(Vector3(5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(-5, 0, 0))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()

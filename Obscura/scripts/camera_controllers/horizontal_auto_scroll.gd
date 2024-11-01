class_name HorizontalAutoScroll
extends CameraControllerBase

@export var top_left := Vector2(-10, 10)
@export var bottom_right := Vector2(10, -10)
@export var autoscroll_speed := Vector3(5, 0, 5)

func _ready() -> void:
	super()
	position = target.position


func _process(delta: float) -> void:
	if !current:
		position = target.position
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	#Vessel and camera autoscroll
	var cam_autoscroll: Vector3 = autoscroll_speed * delta
	global_position += cam_autoscroll
	target.global_position += cam_autoscroll
	
	#Setting boundaries and vessel push
	var left_bound = (tpos.x - target.WIDTH / 2.0) - (cpos.x + top_left.x)
	if left_bound < 0:
		target.global_position.x -= left_bound
		
	var top_bound = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + top_left.y)
	if top_bound > 0:
		target.global_position.z -= top_bound
		
	var right_bound = (tpos.x + target.WIDTH / 2.0) - (cpos.x + bottom_right.x)
	if right_bound > 0:
		target.global_position.x -= right_bound
	
	var bot_bound = (tpos.z - target.HEIGHT / 2.0) - (cpos.z + bottom_right.y)
	if bot_bound < 0:
		target.global_position.z -= bot_bound
	
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left: float = top_left.x
	var top: float = top_left.y
	var right: float = bottom_right.x
	var bottom: float = bottom_right.y
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()

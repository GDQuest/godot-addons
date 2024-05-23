@tool
class_name Quaternion3D extends Node3D

const QUATERNION_3D_ANGLE_SHADER := preload("quaternion_3d_angle.gdshader")

@export var data := Quaternion(Vector3.UP, 0.5 * PI):
	set(new_data):
		if data_axis.is_zero_approx():
			return

		data = new_data
		data_axis = data.get_axis().normalized()
		data_angle = data.get_angle()

		_label.text = "%.3f°" % rad_to_deg(data_angle)

		_pivot.rotation = Vector3.ZERO
		if data_axis.abs().is_equal_approx(Vector3.UP):
			if data_axis.sign().y < 0.0:
				_pivot.rotation.z = PI
		else:
			var rotate_axis := Vector3.UP.cross(data_axis).normalized()
			_pivot.rotate(rotate_axis, Vector3.UP.angle_to(data_axis))

		if _angle.mesh != null:
			_angle.mesh.material.set_shader_parameter("angle_ratio", data_angle / TAU)

@export var data_axis := Vector3.UP:
	set(new_data_axis):
		if new_data_axis.is_zero_approx() or data_axis.is_equal_approx(new_data_axis):
			return

		data_axis = new_data_axis.normalized()
		data = Quaternion(data_axis, data.get_angle())

@export_range(1, 359, 0.001, "radians_as_degrees") var data_angle := 0.5 * PI:
	set(new_data_angle):
		if (
			is_zero_approx(new_data_angle)
			or data.get_axis().is_zero_approx()
			or is_equal_approx(data_angle, new_data_angle)
		):
			return

		data_angle = new_data_angle
		data = Quaternion(data.get_axis().normalized(), data_angle)

@export_category("Cosmetics")

@export var color := Color.WHITE:
	set(new_color):
		color = new_color
		if _angle.mesh == null or _disk.mesh == null:
			return

		_axis.color = color
		_angle.mesh.surface_get_material(0).set_shader_parameter("color", color)
		_disk.mesh.surface_get_material(0).albedo_color = color
		disk_alpha = disk_alpha

@export_range(0.0, 1.0) var disk_alpha := 0.3:
	set(new_disk_transparency):
		if _disk.mesh == null:
			return

		disk_alpha = new_disk_transparency
		_disk.mesh.surface_get_material(0).albedo_color.a = disk_alpha

@export_range(0.001, 1.0, 0.001, "or_greater", "suffix:m") var stem_radius := 0.05:
	set(new_stem_radius):
		stem_radius = new_stem_radius
		_axis.stem_radius = stem_radius

@export_range(0.001, 1.0, 0.001, "or_greater", "suffix:m") var pointer_radius := 0.1:
	set(new_pointer_radius):
		pointer_radius = new_pointer_radius
		_axis.pointer_radius = pointer_radius

@export_range(0.001, 1.0, 0.001, "or_greater", "suffix:m") var pointer_height := 0.3:
	set(new_pointer_height):
		pointer_height = new_pointer_height
		_axis.pointer_height = pointer_height

@export_range(0.001, 0.1, 0.001, "or_greater", "suffix:m") var angle_thickness := 0.02:
	set(new_angle_thickness):
		angle_thickness = new_angle_thickness
		_angle.mesh.inner_radius = 0.5 - 0.5 * angle_thickness
		_angle.mesh.outer_radius = 0.5 + 0.5 * angle_thickness

var _pivot := Node3D.new()
var _axis := Vector3D.new()
var _angle := MeshInstance3D.new()
var _disk := MeshInstance3D.new()
var _label := Label3D.new()


func _ready() -> void:
	add_child(_pivot)
	_pivot.add_child(_axis)
	_axis.position.y -= _axis.data.y / 2.0

	_pivot.add_child(_disk)
	_disk.mesh = CylinderMesh.new()
	_disk.mesh.rings = 0
	_disk.mesh.height = 0

	var standard_material := StandardMaterial3D.new()
	standard_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	standard_material.albedo_color.a = 0.3
	_disk.mesh.surface_set_material(0, standard_material)

	_pivot.add_child(_angle)
	_angle.mesh = TorusMesh.new()
	_angle.mesh.inner_radius = 0.49
	_angle.mesh.outer_radius = 0.51

	_pivot.add_child(_label)
	_label.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	_label.font_size = 16
	_label.outline_size = _label.font_size / 2
	_label.no_depth_test = true
	_label.render_priority = 2
	_label.outline_render_priority = _label.render_priority - 1
	_label.position.z = -0.25
	_label.rotation.x = -0.5 * PI

	var shader_material = ShaderMaterial.new()
	shader_material.shader = QUATERNION_3D_ANGLE_SHADER
	_angle.mesh.surface_set_material(0, shader_material)

	data = data
	color = color
	disk_alpha = disk_alpha
	stem_radius = stem_radius
	pointer_radius = pointer_radius
	pointer_height = pointer_height

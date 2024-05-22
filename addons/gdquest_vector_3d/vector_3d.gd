@tool
class_name Vector3D extends Node3D

@export_range(0.001, 1.0, 0.001, "or_greater", "suffix:m") var stem_radius := 0.05:
	set(new_stem_radius):
		if _stem == null:
			return

		stem_radius = new_stem_radius
		_stem.mesh.top_radius = stem_radius
		_stem.mesh.bottom_radius = _stem.mesh.top_radius

@export_range(0.001, 1.0, 0.001, "or_greater", "suffix:m") var pointer_radius := 0.1:
	set(new_pointer_radius):
		if _pointer == null:
			return

		pointer_radius = new_pointer_radius
		_pointer.mesh.bottom_radius = pointer_radius

@export_range(0.001, 1.0, 0.001, "or_greater", "suffix:m") var pointer_height := 0.3:
	set(new_pointer_height):
		if _stem == null or _pointer == null:
			return

		pointer_height = new_pointer_height
		_pointer.mesh.height = pointer_height
		_pointer.position.y = _stem.mesh.height + 0.5 * _pointer.mesh.height

@export_custom(PROPERTY_HINT_NONE, "suffix:m") var target_position := Vector3.UP:
	set(new_target_position):
		if _stem == null or _pointer == null or new_target_position.is_zero_approx():
			return

		target_position = new_target_position

		_stem.mesh.height = target_position.length()
		_stem.position.y = 0.5 * _stem.mesh.height
		_pointer.position.y = _stem.mesh.height + 0.5 * _pointer.mesh.height

		_pivot.rotation = Vector3.ZERO
		if target_position.abs().normalized().is_equal_approx(Vector3.UP):
			if target_position.sign().y < 0.0:
				_pivot.rotation.z = PI
		else:
			var axis := Vector3.UP.cross(target_position).normalized()
			_pivot.rotate(axis, Vector3.UP.angle_to(target_position))

@export_color_no_alpha var color := Color.WHITE:
	set(new_color):
		if _stem == null or _pointer == null:
			return

		color = new_color
		_stem.mesh.surface_get_material(0).albedo_color = color

var _pivot: Node3D = null
var _stem: MeshInstance3D = null
var _pointer: MeshInstance3D = null


func _ready() -> void:
	_pivot = Node3D.new()
	add_child(_pivot)

	_stem = MeshInstance3D.new()
	_pivot.add_child(_stem)
	_stem.mesh = CylinderMesh.new()
	_stem.mesh.surface_set_material(0, StandardMaterial3D.new())

	_pointer = MeshInstance3D.new()
	_pivot.add_child(_pointer)
	_pointer.mesh = CylinderMesh.new()
	_pointer.mesh.top_radius = 0.0
	_pointer.mesh.surface_set_material(0, _stem.mesh.material)

	stem_radius = stem_radius
	pointer_radius = pointer_radius
	pointer_height = pointer_height
	target_position = target_position

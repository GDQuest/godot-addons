@tool
class_name KennyPrototypeMaterial3D extends StandardMaterial3D

const TEXTURES_DIR := "textures"

@export var color := Color.WHITE:
	set(value):
		color = value
		albedo_color = color

var textures := []

var type := 0:
	set(value):
		type = value
		for texture in textures.slice(type, type + 1):
			albedo_texture = load(texture.path)
			uv1_triplanar = (
				texture.name.begins_with("plain") or texture.name.begins_with("checkers")
			)
			uv1_scale.x = 1 if uv1_triplanar else -1


func _init() -> void:
	super()
	var textures_path: String = get_script().resource_path.get_base_dir().path_join(TEXTURES_DIR)
	textures = (
		Array(DirAccess.get_files_at(textures_path))
		. filter(func(fn: String): return not fn.ends_with(".import"))
		. map(
			func(fn: String): return {name = fn.get_basename(), path = textures_path.path_join(fn)}
		)
	)
	type = type


func _get_property_list() -> Array:
	return [
		{
			name = "type",
			type = TYPE_INT,
			hint = PROPERTY_HINT_ENUM,
			hint_string = ",".join(textures.map(func(d: Dictionary): return d.name.capitalize()))
		}
	]

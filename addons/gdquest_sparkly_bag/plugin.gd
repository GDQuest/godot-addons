@tool
extends EditorPlugin

const Utils := preload("sparkly_bag_utils.gd")

const AUTOLOADS_DIR := "autoloads"
var autoloads := []


func _enter_tree() -> void:
	var root_path: String = get_script().resource_path.get_base_dir()
	var found := Utils.fs_find("*.gd", root_path.path_join(AUTOLOADS_DIR))
	if found.return_code != Utils.ReturnCode.OK:
		return

	for path: String in found.result:
		var scene_path: String = path.replace(".gd", ".tscn")
		var autoload: String = path.get_file().get_basename().capitalize().replace(" ", "")
		add_autoload_singleton(autoload, scene_path if FileAccess.file_exists(scene_path) else path)
		autoloads.push_back(autoload)


func _exit_tree() -> void:
	for autoload in autoloads:
		remove_autoload_singleton(autoload)

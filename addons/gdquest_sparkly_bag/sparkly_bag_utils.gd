const SEP := "/"


static func fs_find(pattern: String = "*", path: String = "res://") -> Array[String]:
	var result: Array[String] = []
	var is_file := not pattern.ends_with(SEP)

	var dir := DirAccess.open(path)
	if DirAccess.get_open_error() != OK:
		printerr("ERROR: could not open [%s]" % path)
		return result

	if dir.list_dir_begin() != OK:
		printerr("ERROR: could not list contents of [%s]" % path)
		return result

	path = dir.get_next()
	while path.is_valid_filename():
		var new_path: String = dir.get_current_dir().path_join(path)
		if dir.current_is_dir():
			if path.match(pattern.rstrip(SEP)) and not is_file:
				result.push_back(new_path)
			result += fs_find(pattern, new_path)
		elif path.match(pattern):
			result.push_back(new_path)
		path = dir.get_next()
	return result


static func fs_remove_dir(base_path: String) -> void:
	if not DirAccess.dir_exists_absolute(base_path):
		return
	for path in fs_find("*", base_path):
		DirAccess.remove_absolute(path)

	var paths := fs_find("*/", base_path)
	paths.reverse()
	for path in paths:
		DirAccess.remove_absolute(path)
	DirAccess.remove_absolute(base_path)


static func fs_copy_dir(from_path: String, to_path: String, ignore: Array[String] = []) -> void:
	var dir := DirAccess.open(from_path)
	from_path = dir.get_current_dir()
	var from_base_path := from_path.get_base_dir()
	for file_path: String in fs_find("*", from_path):
		if ignore.any(func(p: String) -> bool: return file_path.match(p)):
			continue
		var destination_file_path := file_path.replace(from_base_path, to_path)
		var destination_dir_path := destination_file_path.get_base_dir()
		DirAccess.make_dir_recursive_absolute(destination_dir_path)
		DirAccess.copy_absolute(file_path, destination_file_path)

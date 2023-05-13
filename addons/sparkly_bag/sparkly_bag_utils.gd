class_name SparklyBagUtils


static func fs_find(pattern: String = "*", path: String = "res://") -> Array:
	var result := []
	var is_glob = "*" in pattern or "?" in pattern

	var dir := DirAccess.open(path)
	if dir.get_open_error() != OK:
		printerr("ERROR: could not open [%s]" % path)
		return result

	if dir.list_dir_begin() != OK:
		printerr("ERROR: could not list contents of [%s]" % path)
		return result

	path = dir.get_next()
	while path.is_valid_filename():
		var new_path: String = dir.get_current_dir().path_join(path)
		if dir.current_is_dir():
			result += fs_find(pattern, new_path)
		elif path.match(pattern):
			result.push_back(new_path)
		path = dir.get_next()

	return result

@tool
extends EditorScenePostImport


const SUFFIXES = ["-anim", "-col"]
const AABB_SIZE := "aabb_size"


func _post_import(scene: Node) -> Object:
	for node in scene.find_children("*"):
		if node.name.ends_with("-anim") and node is MeshInstance3D:
			node.create_convex_collision()
			var animatable_body := AnimatableBody3D.new()
			animatable_body.name = "AnimatableBody3D"
			animatable_body.sync_to_physics = false
			for child in node.get_children():
				# BUG: where the collision shape doesn't get transformed if `sync_to_physics = true`
				child.replace_by(animatable_body)
				child.free()
			node.name = node.name.replace("-anim", "")

		elif node.name.ends_with("-rigid"):
			node.name = node.name.replace("-rigid", "")

		elif node is AnimationPlayer:
			for animation_name in node.get_animation_list():
				var animation_library: AnimationLibrary = node.get_animation_library("")
				var animation: Animation = node.get_animation(animation_name)
				if animation_name.ends_with("-noimp"):
					animation_library.remove_animation(animation_name)
					continue

				for track_index in range(animation.get_track_count()):
					var path := animation.track_get_path(track_index)
					var clean_path := ""
					for name_index in range(path.get_name_count()):
						for suffix in SUFFIXES:
							var path_name := path.get_name(name_index)
							if path_name.ends_with(suffix):
								clean_path = clean_path.path_join(path_name.replace(suffix, ""))
								break

					if not clean_path.is_empty():
						animation.track_set_path(track_index, clean_path)

		if node is MeshInstance3D:
			var aabb: AABB = node.mesh.get_aabb()
			for index in range(node.mesh.get_surface_count()):
				var material_file_name: StringName = (
					"%s.tres" % node.mesh.get("surface_%d/name" % index).to_snake_case()
				)
				var paths := SparklyBagUtils.fs_find(material_file_name)
				if paths.is_empty():
					print(
						"[ScenePostImport:WARN] Missing material `%s` for `%s`"
						 % [material_file_name, node.name]
					)
				else:
					for path in paths:
						var material := load(path)
						material.set_shader_parameter(AABB_SIZE, aabb.size)
						node.mesh.surface_set_material(index, material)
						print(
							"[ScenePostImport:INFO] Material found @ `%s` for `%s`"
							 % [path, node.name]
						)
						break
	return scene
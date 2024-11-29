# GDQuest Godot Addons

This is part of a GDQuest Godot repository containing multiple addons:

- [GDQuest ColorPicker Presets](addons/gdquest_colorpicker_presets)
- [GDQuest Prototype Material](addons/gdquest_prototype_material)
- [GDQuest Sparkly Bag](addons/gdquest_sparkly_bag)
- [GDQuest Theme Utils](addons/gdquest_theme_utils)
- [GDQuest Vector3D](addons/gdquest_3d_math_visualizer)

## ✓ Install

### Manual

1. Copy any `addons/PLUGIN_NAME` into `res://addons/PLUGIN_NAME`.
1. Enable the addon from `Project > Project Settings... > Plugins`.

### gd-plug

1. Install **gd-plug** using the Godot Asset Library.
1. Save the following code into the file `res://plug.gd` (create the file if necessary):

  ```gdscript
  #!/usr/bin/env -S godot --headless --script
  extends "res://addons/gd-plug/plug.gd"


  func _plugging() -> void:
  	plug(
  		"git@github.com:GDQuest/godot-addons.git",
  		{include = ["addons/PLUGIN_NAME"]}
  	)
  ```

1. On Linux, make the `res://plug.gd` script executable with `chmod +x plug.gd`.
1. Using the command line, run `./plug.gd install` or `godot --headless --script plug.gd install`.

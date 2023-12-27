# GDQuest Prototype Material

Adds a 3D prototype material called `PrototypeMaterial3D` that uses a simple checkerboard texture.

## ✗ WARNING

> Compatible: Godot `>= v4.0`

## ✓ Install

### Manual

1. Copy the contents of this folder into `res://addons/gdquest_prototype_material/`.
1. Enable the addon from `Project > Project Settings... > Plugins`.
1. Profit.

### gd-plug

1. Install **gd-plug** using the Godot Asset Library.
1. Save the following code into the file `res://plug.gd` (create the file if necessary):

  ```gdscript
  #!/usr/bin/env -S godot --headless --script
  extends "res://addons/gd-plug/plug.gd"


  func _plugging() -> void:
  	plug(
  		"git@github.com:GDQuest/godot-addons.git",
  		{include = ["addons/gdquest_prototype_material"]}
  	)
  ```

1. On Linux, make the `res://plug.gd` script executable with `chmod +x plug.gd`.
1. Using the command line, run `./plug.gd install` or `godot --headless --script plug.gd install`.

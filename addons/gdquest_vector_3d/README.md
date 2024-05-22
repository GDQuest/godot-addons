# GDQuest Vector3D

Adds a `Vector3D` node for visualizing 3D vectors in real-time and in the editor.

It has controls for:

- *Stem Radius*: the radius of the base cylinder mesh.
- *Pointer Radius*: the radius for the cone mesh at the top pointing the direction.
- *Pointer Height*: the height for the cone mesh.
- *Target Position*: the `Vector3` value that describes where the node points to relative to its position. It works like `RayCast3D`.
- *Color*: the color of the meshes.

## ✗ WARNING

> Compatible: Godot `>= v4.3`

## ✓ Install

### Manual

1. Copy the contents of this folder into `res://addons/gdquest_vector_3d/`.
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
  		{include = ["addons/gdquest_vector_3d"]}
  	)
  ```

1. On Linux, make the `res://plug.gd` script executable with `chmod +x plug.gd`.
1. Using the command line, run `./plug.gd install` or `godot --headless --script plug.gd install`.

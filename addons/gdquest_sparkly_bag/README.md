# GDQuest Sparkly Bag Utils

Is a collection of utilities dealing with repeating patterns that we discovered in time.

They're not necessarily related to each other, and some are generic while others are very specific.

The collection includes:

- Autoloads added/removed automatically when enabling/disabling the plugin:

  - Background injector for a unified 2D look. It loads an image located at `autoloads/background_injector/background.png`.

- A post import script for GLTF resources that cleans up any inconsistencies with naming conventions and adds support for `AnimatableBody3D` convention via the `-anim` suffix.
- A utility library called `SparklyBagUtils`.

## ✗ WARNING

> Compatible: Godot `>= v4.0`

## ✓ Install

### Manual

1. Copy the contents of this folder into `res://addons/gdquest_sparkly_bag/`.
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
  		{include = ["addons/gdquest_sparkly_bag"]}
  	)
  ```

1. On Linux, make the `res://plug.gd` script executable with `chmod +x plug.gd`.
1. Using the command line, run `./plug.gd install` or `godot --headless --script plug.gd install`.

## Development

### Autoloads

Autoloads are any scripts or scenes located under the `autoloads` directory. Scenes with same name as scripts take precedence.

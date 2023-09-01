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

1. Make a new folder at `res://addons/sparkly_bag/`.
1. Copy the contents of this repository into `res://addons/sparkly_bag/`.
1. Enable the addon from `Project > Project Settings... > Plugins`.
1. Profit.

## Development

### Autoloads

Autoloads are any scripts or scenes located under the `autoloads` directory. Scenes with same name as scripts take precedence.

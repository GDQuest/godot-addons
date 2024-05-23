@tool
class_name Basis3D extends Node3D

@export var data := Basis():
	set(new_data):
		data = new_data
		for index in range(3):
			vectors[index].data = data[index]

@export_category("Cosmetics")

@export var color_x := Color("#C41D3D"):
	set(new_color_x):
		color_x = new_color_x
		x.color = color_x

@export var color_y := Color("#63CC5F"):
	set(new_color_y):
		color_y = new_color_y
		y.color = color_y

@export var color_z := Color("#007AC3"):
	set(new_color_z):
		color_z = new_color_z
		z.color = color_z

@export_range(0.001, 1.0, 0.001, "or_greater", "suffix:m") var stem_radius := 0.05:
	set(new_stem_radius):
		stem_radius = new_stem_radius
		for index in range(3):
			vectors[index].stem_radius = stem_radius

@export_range(0.001, 1.0, 0.001, "or_greater", "suffix:m") var pointer_radius := 0.1:
	set(new_pointer_radius):
		pointer_radius = new_pointer_radius
		for index in range(3):
			vectors[index].pointer_radius = pointer_radius

@export_range(0.001, 1.0, 0.001, "or_greater", "suffix:m") var pointer_height := 0.3:
	set(new_pointer_height):
		pointer_height = new_pointer_height
		for index in range(3):
			vectors[index].pointer_height = pointer_height

var x := Vector3D.new()
var y := Vector3D.new()
var z := Vector3D.new()

var vectors: Array[Vector3D] = [x, y, z]


func _ready() -> void:
	for vector in vectors:
		add_child(vector)

	color_x = color_x
	color_y = color_y
	color_z = color_z
	stem_radius = stem_radius
	pointer_radius = pointer_radius
	pointer_height = pointer_height
	data = data

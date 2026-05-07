@icon("./model_viewer_3d.svg")
extends Node3D

@export var model_data: ModelData = null

var model: Node3D = null
var current_animations := []
var current_range_values := []
var dropdown_list := []

@onready var model_tag: PanelContainer = %ModelTag
@onready var animation_selector: OptionButton = %AnimationSelector
@onready var turner: Node3D = %Turner
@onready var parameters: MarginContainer = %Parameters
@onready var model_holder: Node3D = %ModelHolder


func _ready() -> void:
	model_data.scene = load(model_data.scene_path)
	set_model()
	animation_selector.item_selected.connect(
		func(item_index: int) -> void:
			call_method(current_animations[item_index].value)
	)


func set_model() -> void:
	# Set the new current model node
	model = model_data.scene.instantiate()

	model_tag.tag_name = model_data.name
	model_tag.icon_texture = model_data.vignette

	# Set a model wrapper and put the model in it
	var base_scale := Vector3.ONE * model_data.scale_compensation
	var wrapper = Node3D.new()
	wrapper.position.y = model_data.y_offset
	wrapper.scale = base_scale * 0.8
	wrapper.add_child(model)
	model_holder.add_child(wrapper)

	var t = create_tween().set_parallel(true)
	t.tween_property(turner, "position:y", model_data.camera_offset_y, 0.2)
	t.tween_property(wrapper, "scale", base_scale, 0.2)

	# Set animations
	animation_selector.hide()
	current_animations = model_data.animations_list
	if current_animations.size() != 0:
		var method_names = current_animations.map(func(m: Dictionary) -> String: return m.name)
		animation_selector.setup(method_names)
		animation_selector.show()
		call_method(current_animations[0].value)

	# Check if the parameters panel already show something, remove the children if so.
	if parameters.has_childrens():
		parameters.clear()

	# Ranges
	current_range_values = model_data.range_bind
	if current_range_values.size() != 0:
		for range_index in current_range_values.size():
			var slider: HSlider = parameters.add_slider(current_range_values[range_index].name)
			slider.value_changed.connect(
				func(value: float) -> void:
					set_variable(current_range_values[range_index].value, remap(value, 0, 100, 0, 1))
			)
	# Dropdown
	dropdown_list = []
	for option_setter_index in model_data.dropdown_bind.size():
		var setter := model_data.dropdown_bind[option_setter_index]
		var options := model_data._get_options(option_setter_index)
		var options_names := options.map(func(m: Dictionary) -> String: return m.name)
		dropdown_list.append(
			{
				"bind_variable": setter.bind_name,
				"options": options,
			},
		)
		var option_button: OptionButton = parameters.add_options(setter.list_name, options_names)
		option_button.item_selected.connect(
			func(dropdown_choice_index: int) -> void:
				var v_value = dropdown_list[option_setter_index].options[dropdown_choice_index].value
				if setter.mode == setter.MODE.SET:
					set_variable(setter.bind_name, v_value)
				elif setter.mode == setter.MODE.CALL:
					model.call(setter.bind_name, v_value)
		)


func call_method(method_name: String) -> void:
	model.call(method_name)


func set_variable(variable_name: String, new_value: Variant) -> void:
	model.set(variable_name, new_value)

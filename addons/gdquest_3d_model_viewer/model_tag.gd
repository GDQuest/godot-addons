extends PanelContainer

@export var tag_name: String:
	set = _set_label

@export var icon_texture: Texture:
	set = _set_icon


func _set_label(value: String) -> void:
	var label = $MarginContainer/Item/Label
	label.text = value


func _set_icon(value: Texture) -> void:
	var icon = $MarginContainer/Item/Icon
	icon.texture = value

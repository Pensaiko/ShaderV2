@tool
extends VisualShaderNodeCustom

class_name VisualShaderNodeRGBAturnCGA4Palette

func _init() -> void:
	set_input_port_default_value(1, 1.5)


func _get_name() -> String:
	return "TurnCGA4Palette"


func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""


func _get_description() -> String:
	return "Swaps color to CGA 4-color palette"


func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_input_port_count() -> int:
	return 2


func _get_input_port_name(port: int) -> String:
	match port:
		0:
			return "color"
		1:
			return "threshold"
	return ""


func _get_input_port_type(port: int) -> VisualShaderNode.PortType:
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_output_port_count() -> int:
	return 1


func _get_output_port_name(_port: int) -> String:
	return "col"


func _get_output_port_type(_port: int) -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_global_code(_mode: VisualShader.Mode) -> String:
	var path: String = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/turnCGA4Palette.gdshaderinc"'


func _get_code(input_vars: Array[String], output_vars: Array[String], _mode: VisualShader.Mode, _type: VisualShader.Type) -> String:
	return "%s = _cg4PaletteFunc(%s, %s);" % [output_vars[0], input_vars[0], input_vars[1]]

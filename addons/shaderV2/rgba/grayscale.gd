@tool
extends VisualShaderNodeCustom

class_name VisualShaderNodeRGBAgrayscale

func _init() -> void:
	set_input_port_default_value(1, 1.0)


func _get_name() -> String:
	return "GrayscalePlus"


func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""


func _get_description() -> String:
	return "Improved grayscale with gray factor"


func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_input_port_count() -> int:
	return 2


func _get_input_port_name(port: int) -> String:
	match port:
		0:
			return "color"
		1:
			return "factor"
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
	return '#include "' + path + '/grayscale.gdshaderinc"'


func _get_code(input_vars: Array[String], output_vars: Array[String], _mode: VisualShader.Mode, _type: VisualShader.Type) -> String:
	return "%s = _grayscaleFunc(%s, %s);" % [output_vars[0], input_vars[0], input_vars[1]]

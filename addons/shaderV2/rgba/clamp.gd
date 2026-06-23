@tool
extends VisualShaderNodeCustom

class_name VisualShaderNodeUVclampAlpha

func _get_name() -> String:
	return "ClampAlphaBorder"


func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""


func _get_description() -> String:
	return "Clamp alpha to border vec4(0, 0, 1, 1)"


func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_input_port_count() -> int:
	return 2


func _get_input_port_name(port: int) -> String:
	match port:
		0:
			return "alpha"
		1:
			return "uv"
	return ""


func _get_input_port_type(port: int) -> VisualShaderNode.PortType:
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_SCALAR
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_output_port_count() -> int:
	return 1


func _get_output_port_name(_port: int) -> String:
	return "alpha"


func _get_output_port_type(_port: int) -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_global_code(_mode: VisualShader.Mode) -> String:
	var path: String = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/clamp.gdshaderinc"'


func _get_code(input_vars: Array[String], output_vars: Array[String], _mode: VisualShader.Mode, _type: VisualShader.Type) -> String:
	var _texture: String = "TEXTURE"
	var uv: String = "UV"

	if input_vars[1]:
		uv = input_vars[1]

	return output_vars[0] + " = _clampAlphaBorderFunc(%s, (%s).xy);" % [input_vars[0], uv]

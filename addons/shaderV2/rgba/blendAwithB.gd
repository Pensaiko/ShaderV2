@tool
extends VisualShaderNodeCustom

class_name VisualShaderNodeRGBAblend

func _init() -> void:
	set_input_port_default_value(1, 1.0)
	set_input_port_default_value(3, 1.0)
	set_input_port_default_value(4, 1.0)


func _get_name() -> String:
	return "BlendAwithB"


func _get_category() -> String:
	return "RGBA"

#func _get_subcategory():
#	return ""


func _get_description() -> String:
	return "Blends colors basing on fade"


func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_input_port_count() -> int:
	return 5


func _get_input_port_name(port: int) -> String:
	match port:
		0:
			return "colorDown"
		1:
			return "alphaDown"
		2:
			return "colorUp"
		3:
			return "alphaUp"
		4:
			return "fade"
	return ""


func _get_input_port_type(port: int) -> VisualShaderNode.PortType:
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		3:
			return VisualShaderNode.PORT_TYPE_SCALAR
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_output_port_count() -> int:
	return 2


func _get_output_port_name(port: int) -> String:
	match port:
		0:
			return "col"
		1:
			return "alpha"
	return ""


func _get_output_port_type(port: int) -> VisualShaderNode.PortType:
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_global_code(_mode: VisualShader.Mode) -> String:
	var path: String = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/blendAwithB.gdshaderinc"'


func _get_code(input_vars: Array[String], output_vars: Array[String], _mode: VisualShader.Mode, _type: VisualShader.Type) -> String:
	return """vec4 %s%s = _blendAwithBFunc(vec4(%s, %s), vec4(%s, %s), %s);
%s = %s%s.rgb;
%s = %s%s.a;""" % [
		output_vars[0],
		output_vars[1],
		input_vars[0],
		input_vars[1],
		input_vars[2],
		input_vars[3],
		input_vars[4],
		output_vars[0],
		output_vars[0],
		output_vars[1],
		output_vars[1],
		output_vars[0],
		output_vars[1],
	]

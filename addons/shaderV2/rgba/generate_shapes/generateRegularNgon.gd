@tool
extends VisualShaderNodeCustom

class_name VisualShaderNodeRGBAcreateRegularPolygon

func _init() -> void:
	set_input_port_default_value(1, Vector3(0.5, 0.5, 0))
	set_input_port_default_value(2, 3)
	set_input_port_default_value(3, Vector3(1.0, 1.0, 0.0))
	set_input_port_default_value(4, 0.0)
	set_input_port_default_value(5, 0.0)
	set_input_port_default_value(6, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(7, 1.0)


func _get_name() -> String:
	return "RegularPolygonShape"


func _get_category() -> String:
	return "RGBA"


func _get_subcategory() -> String:
	return "Shapes"


func _get_description() -> String:
	return "Regular N-gon with 3+ sides"


func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_input_port_count() -> int:
	return 8


func _get_input_port_name(port: int) -> String:
	match port:
		0:
			return "uv"
		1:
			return "pos"
		2:
			return "sides"
		3:
			return "size"
		4:
			return "angle"
		5:
			return "smooth"
		6:
			return "color"
		7:
			return "alpha"
	return ""


func _get_input_port_type(port: int) -> VisualShaderNode.PortType:
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		4:
			return VisualShaderNode.PORT_TYPE_SCALAR
		5:
			return VisualShaderNode.PORT_TYPE_SCALAR
		6:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		7:
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
	return '#include "' + path + '/generateRegularNgon.gdshaderinc"'


func _get_code(input_vars: Array[String], output_vars: Array[String], _mode: VisualShader.Mode, _type: VisualShader.Type) -> String:
	var uv: String = "UV"

	if input_vars[0]:
		uv = input_vars[0]

	return """%s = %s;
%s = _polygonFunc(%s.xy, %s.xy, %s.xy, %s, %s, %s) * %s;""" % [
		output_vars[0],
		input_vars[6],
		output_vars[1],
		uv,
		input_vars[1],
		input_vars[3],
		input_vars[2],
		input_vars[4],
		input_vars[5],
		input_vars[7],
	]

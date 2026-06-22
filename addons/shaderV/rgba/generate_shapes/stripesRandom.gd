@tool
extends VisualShaderNodeCustom

class_name VisualShaderNodeRGBAcreateStripesRandom

func _init() -> void:
	set_input_port_default_value(1, 0.5)
	set_input_port_default_value(2, 20.0)
	set_input_port_default_value(3, Vector3(1.0, 1.0, 1.0))
	set_input_port_default_value(4, 1.0)


func _get_name() -> String:
	return "RandomStripesShape"


func _get_category() -> String:
	return "RGBA"


func _get_subcategory() -> String:
	return "Shapes"


func _get_description() -> String:
	return "Random horizontal lines creation"


func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_input_port_count() -> int:
	return 5


func _get_input_port_name(port: int) -> String:
	match port:
		0:
			return "uv"
		1:
			return "fill"
		2:
			return "amount"
		3:
			return "color"
		4:
			return "alpha"
	return ""


func _get_input_port_type(port: int) -> VisualShaderNode.PortType:
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR
		3:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
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
	return '#include "' + path + '/stripesRandom.gdshaderinc"'


func _get_code(input_vars: Array[String], output_vars: Array[String], _mode: VisualShader.Mode, _type: VisualShader.Type) -> String:
	var uv: String = "UV"

	if input_vars[0]:
		uv = input_vars[0]

	return """%s = %s;
%s = _generateRandomStripesFunc(%s.xy, %s, %s) * float(%s);""" % [
		output_vars[0],
		input_vars[3],
		output_vars[1],
		uv,
		input_vars[1],
		input_vars[2],
		input_vars[4],
	]

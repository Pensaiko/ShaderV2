@tool
extends VisualShaderNodeCustom

class_name VisualShaderToolsRandomFloat4D

func _init() -> void:
	set_input_port_default_value(1, 1.0)


func _get_name() -> String:
	return "RandomFloat4D"


func _get_category() -> String:
	return "Tools"


func _get_subcategory() -> String:
	return "Random"


func _get_description() -> String:
	return "Returns random float value based on 4D input vector"


func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_input_port_count() -> int:
	return 3


func _get_input_port_name(port: int) -> String:
	match port:
		0:
			return "input"
		1:
			return "scale"
		2:
			return "offset"

	return ""


func _get_input_port_type(port: int) -> VisualShaderNode.PortType:
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_4D
		1:
			return VisualShaderNode.PORT_TYPE_SCALAR
		2:
			return VisualShaderNode.PORT_TYPE_VECTOR_4D

	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_output_port_count() -> int:
	return 1


func _get_output_port_name(_port: int) -> String:
	return "rnd"


func _get_output_port_type(_port: int) -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_global_code(_mode: VisualShader.Mode) -> String:
	var path: String = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/randomFloat4D.gdshaderinc"'


func _get_code(input_vars: Array[String], output_vars: Array[String], _mode: VisualShader.Mode, _type: VisualShader.Type) -> String:
	var input: String = input_vars[0]
	var offset: String = input_vars[2]

	# See https://github.com/godotengine/godot/pull/90850
	if not input:
		input = 'vec4(0)'
	if not offset:
		offset = 'vec4(0)'

	return "%s = _randFloat4D(%s * %s + %s);" % [
		output_vars[0],
		input,
		input_vars[1],
		offset,
	]

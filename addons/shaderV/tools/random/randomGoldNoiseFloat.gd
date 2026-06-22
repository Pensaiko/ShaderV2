@tool
extends VisualShaderNodeCustom
class_name VisualShaderToolsRandomFloatGoldenRation

func _init() -> void:
	set_input_port_default_value(0, Vector3(0, 0, 0))
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 0.0)

func _get_name() -> String:
	return "RandomGoldRatio"

func _get_category() -> String:
	return "Tools"

func _get_subcategory() -> String:
	return "Random"

func _get_description() -> String:
	return "Random float based on golden ratio"

func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_input_port_count() -> int:
	return 3

func _get_input_port_name(port: int) -> String:
	match port:
		0:
			return "uv"
		1:
			return "offset"
		2:
			return "seed"

	return ""
func _get_input_port_type(port: int) -> VisualShaderNode.PortType:
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		2:
			return VisualShaderNode.PORT_TYPE_SCALAR

	return VisualShaderNode.PORT_TYPE_SCALAR
func _get_output_port_count() -> int:
	return 1

func _get_output_port_name(_port: int) -> String:
	return "rand"

func _get_output_port_type(_port: int) -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_SCALAR

func _get_global_code(_mode: VisualShader.Mode) -> String:
	var path: String = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/randomGoldNoiseFloat.gdshaderinc"'

func _get_code(input_vars: Array[String], output_vars: Array[String], _mode: VisualShader.Mode, _type: VisualShader.Type) -> String:
	return "%s = _randomGoldRatioFunc(%s.xy, %s.xy, %s);" % [
			output_vars[0], input_vars[0], input_vars[1], input_vars[2]]

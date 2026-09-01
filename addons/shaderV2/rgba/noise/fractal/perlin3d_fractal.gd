@tool
class_name VisualShaderNodeNoisePerlin3dFractal
extends VisualShaderNodeCustom


func _init() -> void:
	set_input_port_default_value(1, 6)
	set_input_port_default_value(2, Vector3(2, 2, 0))
	set_input_port_default_value(3, 2.0)
	set_input_port_default_value(4, 0.8)
	set_input_port_default_value(5, 0.5)
	set_input_port_default_value(6, 0.6)
	set_input_port_default_value(7, Vector3(0.5, 0.5, 0))
	set_input_port_default_value(8, 0.0)


func _get_name() -> String:
	return "FractalPerlinNoise3D"


func _get_category() -> String:
	return "RGBA"


func _get_subcategory() -> String:
	return "NoiseFractal"


func _get_description() -> String:
	return "Fractal 3D Perlin Noise"


func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_input_port_count() -> int:
	return 9


func _get_input_port_name(port: int) -> String:
	return [
		"uv",
		"octaves",
		"period",
		"lacunarity",
		"persistence",
		"angle",
		"amplitude",
		"shift",
		"time",
	][port]


func _get_input_port_type(port: int) -> VisualShaderNode.PortType:
	return [
		VisualShaderNode.PORT_TYPE_VECTOR_3D,
		VisualShaderNode.PORT_TYPE_SCALAR,
		VisualShaderNode.PORT_TYPE_VECTOR_3D,
		VisualShaderNode.PORT_TYPE_SCALAR,
		VisualShaderNode.PORT_TYPE_SCALAR,
		VisualShaderNode.PORT_TYPE_SCALAR,
		VisualShaderNode.PORT_TYPE_SCALAR,
		VisualShaderNode.PORT_TYPE_VECTOR_3D,
		VisualShaderNode.PORT_TYPE_SCALAR,
	][port]


func _get_output_port_count() -> int:
	return 1


func _get_output_port_name(_port: int) -> String:
	return "result"


func _get_output_port_type(_port: int) -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_global_code(_mode: VisualShader.Mode) -> String:
	var current_script: Script = get_script()
	var path: String = ""
	if current_script is Script:
		path = current_script.resource_path.get_base_dir()
	return '#include "' + path + '/perlin3d_fractal.gdshaderinc"'


func _get_code(
	input_vars: Array[String],
	output_vars: Array[String],
	_mode: VisualShader.Mode,
	_type: VisualShader.Type,
) -> String:
	var uv: String = "UV"

	if input_vars[0]:
		uv = input_vars[0]

	return "%s = _perlinNoise3DFBM(%s.xy, int(%s), %s.xy, %s, %s, %s, %s, %s.xy, %s);" % [
		output_vars[0],
		uv,
		input_vars[1],
		input_vars[2],
		input_vars[3],
		input_vars[4],
		input_vars[5],
		input_vars[6],
		input_vars[7],
		input_vars[8],
	]

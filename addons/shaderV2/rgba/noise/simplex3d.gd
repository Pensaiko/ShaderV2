@tool
class_name VisualShaderNodeNoiseSimplex3d
extends VisualShaderNodeCustom


func _init() -> void:
	set_input_port_default_value(1, Vector3(0, 0, 0))
	set_input_port_default_value(2, 5.0)
	set_input_port_default_value(3, 0.0)


func _get_name() -> String:
	return "SimplexNoise3D"


func _get_category() -> String:
	return "RGBA"


func _get_subcategory() -> String:
	return "Noise"


func _get_description() -> String:
	return "3d simplex noise"


func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_input_port_count() -> int:
	return 4


func _get_input_port_name(port: int) -> String:
	return ["uv", "offset", "scale", "time"][port]


func _get_input_port_type(port: int) -> VisualShaderNode.PortType:
	return [
		VisualShaderNode.PORT_TYPE_VECTOR_3D,
		VisualShaderNode.PORT_TYPE_VECTOR_3D,
		VisualShaderNode.PORT_TYPE_SCALAR,
		VisualShaderNode.PORT_TYPE_SCALAR
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
	return '#include "' + path + '/simplex3d.gdshaderinc"'


func _get_code(
	input_vars: Array[String],
	output_vars: Array[String],
	_mode: VisualShader.Mode,
	_type: VisualShader.Type,
) -> String:
	var uv: String = input_vars[0] if not input_vars[0].is_empty() else "(inverse(MODEL_MATRIX) * INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz"

	return "%s = _simplex3dNoiseFunc((%s + %s) * %s + vec3(%s));" % [
		output_vars[0],
		uv,
		input_vars[1],
		input_vars[2],
		input_vars[3],
	]

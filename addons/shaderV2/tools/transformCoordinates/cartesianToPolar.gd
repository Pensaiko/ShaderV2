@tool
extends VisualShaderNodeCustom

class_name VisualShaderToolsCartesianToPolar

func _init() -> void:
	set_input_port_default_value(0, Vector3(1.0, 1.0, 0.0))


func _get_name() -> String:
	return "CartesianToPolar"


func _get_category() -> String:
	return "Tools"


func _get_subcategory() -> String:
	return "TransformCoordinates"


func _get_description() -> String:
	return "Cartesian (x, y) -> Polar (r, theta). By default (x, y) is UV."


func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_input_port_count() -> int:
	return 1


func _get_input_port_name(_port: int) -> String:
	return "cartesian"


func _get_input_port_type(_port: int) -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_output_port_count() -> int:
	return 1


func _get_output_port_name(_port: int) -> String:
	return "polar"


func _get_output_port_type(_port: int) -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_global_code(_mode: VisualShader.Mode) -> String:
	var path: String = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/cartesianToPolar.gdshaderinc"'


func _get_code(input_vars: Array[String], output_vars: Array[String], _mode: VisualShader.Mode, _type: VisualShader.Type) -> String:
	var uv: String = "UV"

	if input_vars[0]:
		uv = input_vars[0]

	return "%s = vec3(_cartesianToPolarFunc(%s.xy), %s.z);" % [output_vars[0], uv, uv]

@tool
extends VisualShaderNodeCustom

class_name VisualShaderToolsSphericalToCartesian

func _init() -> void:
	set_input_port_default_value(0, Vector3(1.0, 1.0, 1.0))


func _get_name() -> String:
	return "SphericalToCartesian"


func _get_category() -> String:
	return "Tools"


func _get_subcategory() -> String:
	return "TransformCoordinates"


func _get_description() -> String:
	return "Spherical (r, theta, phi) -> Cartesian (x, y, z)"


func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_input_port_count() -> int:
	return 1


func _get_input_port_name(_port: int) -> String:
	return "spherical"


func _get_input_port_type(_port: int) -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_output_port_count() -> int:
	return 1


func _get_output_port_name(_port: int) -> String:
	return "cartesian"


func _get_output_port_type(_port: int) -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_global_code(_mode: VisualShader.Mode) -> String:
	var path: String = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/sphericalToCartesian.gdshaderinc"'


func _get_code(input_vars: Array[String], output_vars: Array[String], _mode: VisualShader.Mode, _type: VisualShader.Type) -> String:
	return "%s = _sphericalToCartesianFunc(%s);" % [output_vars[0], input_vars[0]]

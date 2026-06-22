@tool
extends VisualShaderNodeCustom

class_name VisualShaderNodeUVrotateAnimated

func _init() -> void:
	set_input_port_default_value(1, 0.5)
	set_input_port_default_value(2, Vector3(0.5, 0.5, 0))


func _get_name() -> String:
	return "RotateUVAnimated"


func _get_category() -> String:
	return "UV"


func _get_subcategory() -> String:
	return "Animated"


func _get_description() -> String:
	return "Animated UV rotation by angle in radians relative to pivot point"


func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_input_port_count() -> int:
	return 4


func _get_input_port_name(port: int) -> String:
	match port:
		0:
			return "uv"
		1:
			return "angularSpeed"
		2:
			return "pivot"
		3:
			return "time"

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

	return VisualShaderNode.PORT_TYPE_SCALAR


func _get_output_port_count() -> int:
	return 1


func _get_output_port_name(_port: int) -> String:
	return "uv"


func _get_output_port_type(_port: int) -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_global_code(_mode: VisualShader.Mode) -> String:
	var path: String = self.get_script().get_path().get_base_dir()
	return '#include "' + path + '/rotateAnimated.gdshaderinc"'


func _get_code(input_vars: Array[String], output_vars: Array[String], _mode: VisualShader.Mode, _type: VisualShader.Type) -> String:
	var uv: String = "UV"

	if input_vars[0]:
		uv = input_vars[0]

	return output_vars[0] + " = vec3(_rotateUVAnimatedFunc(%s.xy, %s.xy, 0.0, %s, %s), 0);" % [
		uv,
		input_vars[2],
		input_vars[1],
		input_vars[3],
	]

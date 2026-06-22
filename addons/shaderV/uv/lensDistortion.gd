@tool
extends VisualShaderNodeCustom

class_name VisualShaderNodeUVlensDistortion

func _init() -> void:
	set_input_port_default_value(1, 1.0)


func _get_name() -> String:
	return "LensDistortionUV"


func _get_category() -> String:
	return "UV"

#func _get_subcategory():
#	return ""


func _get_description() -> String:
	return """Lens distortion effect.
[factor] > 0 - fisheye / barrel;
[factor] < 0 - antifisheye / pincushion"""


func _get_return_icon_type() -> VisualShaderNode.PortType:
	return VisualShaderNode.PORT_TYPE_VECTOR_3D


func _get_input_port_count() -> int:
	return 2


func _get_input_port_name(port: int) -> String:
	match port:
		0:
			return "uv"
		1:
			return "factor"

	return ""


func _get_input_port_type(port: int) -> VisualShaderNode.PortType:
	match port:
		0:
			return VisualShaderNode.PORT_TYPE_VECTOR_3D
		1:
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
	return '#include "' + path + '/lensDistortion.gdshaderinc"'


func _get_code(input_vars: Array[String], output_vars: Array[String], _mode: VisualShader.Mode, _type: VisualShader.Type) -> String:
	var uv: String = "UV"

	if input_vars[0]:
		uv = input_vars[0]

	return "%s.xy = _lensDistortionUV(%s.xy, %s);" % [output_vars[0], uv, input_vars[1]]

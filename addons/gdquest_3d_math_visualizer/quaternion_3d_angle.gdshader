shader_type spatial;
render_mode depth_prepass_alpha, cull_disabled, shadows_disabled;

uniform vec3 color: source_color = vec3(1.0);
uniform float angle_ratio: hint_range(-1.0, 1.0) = 0.0;

void fragment() {
	ALBEDO = color;
	ALPHA = step(UV.x, abs(angle_ratio));
}

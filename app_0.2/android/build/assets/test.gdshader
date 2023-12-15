shader_type canvas_item;

void fragment() {
    COLOR = vec4(UV.x, UV.y, 1, 1.0);
	COLOR.xyz = vec3(sin(UV.x * 3.14159 * 4.0) * cos(UV.y * 3.14159 * 4.0) * 0.5 + 0.5);
}
shader_type canvas_item;

uniform vec2 scroll_direction = vec2(1.0, 0.0);
uniform float speed = 0.5;

void fragment() {
    vec2 uv = fract(UV + scroll_direction * TIME * speed);

    vec4 tex = texture(TEXTURE, uv);

    // Use MODULATE instead of COLOR
    COLOR = tex * MODULATE;
}
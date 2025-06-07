shader_type canvas_item;

uniform float edge_softness : hint_range(0.0, 0.1) = 0.01;

void fragment() {
    vec2 center = vec2(0.5, 0.5);
    float radius = 0.5;
    float dist = distance(UV, center);

    float alpha = 1.0 - smoothstep(radius - edge_softness, radius, dist);
    COLOR = texture(TEXTURE, UV);
    COLOR.a *= alpha;
}
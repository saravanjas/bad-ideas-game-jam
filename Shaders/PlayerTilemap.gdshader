shader_type canvas_item;
uniform vec2 poz;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float udaljenost = distance(SCREEN_UV , vec2(poz));
	COLOR.a *= 1. - smoothstep(0.05 , 0.2 , udaljenost);  
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

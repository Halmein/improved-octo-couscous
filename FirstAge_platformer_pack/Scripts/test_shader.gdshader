shader_type canvas_item;

uniform float scale : hint_range(0.1, 10) = 1.0;
uniform float distortion : hint_range(-1.0, 1.0) = 0.0;
uniform float brightness : hint_range(0.0, 5.0) = 1.5;
uniform float flash : hint_range(0.0, 1.0) = 0.0;
uniform vec4 color : source_color = vec4(1.0);

void fragment() {
	vec2 distortedUV = UV;
	distortedUV.x += distortedUV.y * distortion;
	vec4 pixelColor = texture(TEXTURE, distortedUV * scale);
	
	//controlls only the brightness
	float bright = (pixelColor.r + pixelColor.g + pixelColor.b) / brightness;
	vec4 grayScale = vec4(bright, bright, bright, pixelColor.a);
	
	//determines the final result
	COLOR = mix(pixelColor, grayScale * color, flash);
	COLOR.a *= pixelColor.a;
}

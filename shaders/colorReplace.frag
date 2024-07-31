#pragma header

uniform vec3 u_colorToReplace;
uniform vec3 u_replacementColor;
void main() {
    vec4 col = flixel_texture2D(bitmap, openfl_TextureCoordv);
    
    if (col.rgb == u_colorToReplace)
    col.rgb = u_replacementColor;

    gl_FragColor = col;
}
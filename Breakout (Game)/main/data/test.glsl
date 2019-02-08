uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;

void main()
{
	float t;
	t = time;
    vec2 r = resolution,
    o = gl_FragCoord.xy - r/2.;
    o = vec2(length(o) / r.y - .5, atan(o.y,o.x));    
    vec4 s = 0.05*cos(1.5*vec4(0,1,2,3) + t + o.y + cos(o.y) * cos(t)),
    e = s.yzwx, 
    f = max(o.x-s,e-o.x);
    gl_FragColor = dot(clamp(f*r.y,0.,0.5), 72.*(s-e)) * (s-.1) + f;
}
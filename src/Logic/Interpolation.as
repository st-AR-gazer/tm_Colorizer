InterpolationType currentInterpolationType = InterpolationType::Linear;

enum InterpolationType {
    Linear,
    Quadratic,
    Exponential,
    Cubic,
    Sine,
    Back,
    Elastic,
    Bounce,
    InverseQuadratic,
    Smoothstep,
    Smootherstep,
    Circular
};

array<string> InterpolateColors(int steps, InterpolationType type, const string &in t_u_startColor, const string &in t_u_endColor) {
    array<string> colorArray;

    int sR, sG, sB, eR, eG, eB;
    HexToRgb(t_u_startColor, sR, sG, sB);
    HexToRgb(t_u_endColor, eR, eG, eB);

    for (int step = 0; step < steps; ++step) {
        float t = float(step) / (steps - 1);

        switch (type) {
            case InterpolationType::Quadratic:
                t = t * t;
                break;

            case InterpolationType::Exponential:
                t = Math::Pow(t, 3);
                break;

            case InterpolationType::Cubic:
                t = t * t * (3 - 2 * t);
                break;

            case InterpolationType::Sine:
                t = Math::Sin(t * Math::PI * 0.5);
                break;

            case InterpolationType::Back:
                // float s = 1.70158;
                t = t * t * ((1.70158 + 1) * t - 1.70158);
                break;

            case InterpolationType::Elastic:
                // float p = 0.3;
                t = Math::Pow(2, -10 * t) * Math::Sin((t - 0.3 / 4) * (2 * Math::PI) / 0.3) + 1;
                break;

            case InterpolationType::Bounce:
                if (t < (1 / 2.75)) {
                    t = 7.5625 * t * t;
                } else if (t < (2 / 2.75)) {
                    t -= (1.5 / 2.75);
                    t = 7.5625 * t * t + 0.75;
                } else if (t < (2.5 / 2.75)) {
                    t -= (2.25 / 2.75);
                    t = 7.5625 * t * t + 0.9375;
                } else {
                    t -= (2.625 / 2.75);
                    t = 7.5625 * t * t + 0.984375;
                }
                break;

            case InterpolationType::InverseQuadratic:
                t = 1 - (1 - t) * (1 - t);
                break;

            case InterpolationType::Smoothstep:
                t = t * t * (3 - 2 * t);
                break;

            case InterpolationType::Smootherstep:
                t = t * t * t * (t * (t * 6 - 15) + 10);
                break;

            case InterpolationType::Circular:
                t = 1 - Math::Sqrt(1 - t * t);
                break;


            case InterpolationType::Linear:
            default:
                // Nohing to add here since linear is the default
                break;
        }

        int r = sR + int(float(eR - sR) * t);
        int g = sG + int(float(eG - sG) * t);
        int b = sB + int(float(eB - sB) * t);

        string rHex = Text::Format("%02X", r);
        string gHex = Text::Format("%02X", g);
        string bHex = Text::Format("%02X", b);

        string color = "#" + rHex + gHex + bHex;
        colorArray.InsertLast(color);
    }

    return colorArray;
}

bool uiVisible = false;

string userInput = "";
string colorCode = "#FFFFFF"; 
string previewText = ""; 
string startColor = "#0033CC";
string endColor = "#33FFFF";

void RenderMenu() {
    if (UI::MenuItem("\\$1F1" + Icons::Tachometer + " " + Icons::PaintBrush + "\\$ " + ColorizeString("Colorizer", InterpolationType::InverseQuadratic, "#1DFF1A", "#FFD53D"))) {
        uiVisible = !uiVisible;
    }
}

void Render() {
    if (!uiVisible) { return; }

    UI::Begin("Colorizer", uiVisible);

    UI::InputText("User Input", userInput);
    UI::InputText("Color Code", colorCode);

    previewText = ColorizeString(userInput, currentInterpolationType);
    UI::Text(previewText);

    startColor = UI::InputText("Start Color", startColor);
    endColor = UI::InputText("End Color", endColor);

    string currentTypeName = GetTypeAsString(currentInterpolationType);
    if (UI::BeginCombo("Interpolation Type", currentTypeName)) {
        array<string> types = {"Linear", "Quadratic", "Exponential", "Cubic", "Sine", "Back", "Elastic", "Bounce", "InverseQuadratic", "Smoothstep", "Smootherstep", "Circular"};
        for (uint i = 0; i < types.Length; i++) {
            bool isSelected = (currentTypeName == types[i]);
            if (UI::Selectable(types[i], isSelected)) {
                currentTypeName = types[i];
                currentInterpolationType = InterpolationType(i);
            }
            if (isSelected) {
                UI::SetItemDefaultFocus();
            }
        }
        UI::EndCombo();
    }

    if (UI::Checkbox("Include Escape Characters", includeEscapeCharacters)) {
        ToggleEscapeCharacters();
    }

    if (UI::Button("Reset")) {
        ResetToDefaults();
    }


    UI::Text("I'd recomend using the website for this (TM Color \nCode Formatter), it's more user frindly and has more \nfeatures.");

    UI::End();
}

string GetTypeAsString(InterpolationType type) {
    switch (type) {
        case InterpolationType::Linear: return "Linear";
        case InterpolationType::Quadratic: return "Quadratic";
        case InterpolationType::Exponential: return "Exponential";
        case InterpolationType::Cubic: return "Cubic";
        case InterpolationType::Sine: return "Sine";
        case InterpolationType::Back: return "Back";
        case InterpolationType::Elastic: return "Elastic";
        case InterpolationType::Bounce: return "Bounce";
        case InterpolationType::InverseQuadratic: return "InverseQuadratic";
        case InterpolationType::Smoothstep: return "Smoothstep";
        case InterpolationType::Smootherstep: return "Smootherstep";
        case InterpolationType::Circular: return "Circular";
        default: return "Unknown";
    }
}


void ResetToDefaults() {
    userInput = "";
    colorCode = "#FFFFFF";
    startColor = "#0033CC";
    endColor = "#33FFFF";
    includeEscapeCharacters = false;
    currentInterpolationType = InterpolationType::Linear;
}

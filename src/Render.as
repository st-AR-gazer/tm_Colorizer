bool uiVisible = false;

string userInput = "";
string colorCode = "#FFFFFF"; 
string previewText = ""; 
string u_startColor = "#0033CC";
string u_endColor = "#33FFFF";

// string u_startColor;
// string u_endColor;

void RenderMenu() {
    if (UI::MenuItem("\\$1F1" + Icons::Tachometer + " " + Icons::PaintBrush + "\\$ " + ColorizeString("Colorizer", InterpolationType::InverseQuadratic, "#1DFF1A", "#FFD53D", true))) {
        uiVisible = !uiVisible;
    }
}
string colorizedUserInput;

void RenderInterface() {
    // if (expotOnlyMode) { return; }

    if (!uiVisible) { return; }

    int window_flags = UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking;

    if (UI::Begin("Colorizer", uiVisible, window_flags)) {
        userInput = UI::InputText("String to be Colorized", userInput);

        UI::Text("Preview: " + colorizedUserInput);
        UI::SameLine();
        if (UI::Button("Copy to Clipboard")) {
            IO::SetClipboard(colorizedUserInput);
        }

        UI::Separator();
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
        UI::Separator();

        u_startColor = UI::InputText("Start Color", u_startColor);
        u_endColor = UI::InputText("End Color", u_endColor);
        
        UI::Separator();

        if(UI::Button("Colorize")) {
            InterpolationType selectedType = GetInterpolationTypeFromString(currentTypeName);
            colorizedUserInput = ColorizeString(userInput, selectedType, u_startColor, u_endColor, includeEscapeCharacters);
        }


        includeEscapeCharacters = UI::Checkbox("Include Escape Characters", includeEscapeCharacters);

        if (UI::Button("Reset")) {
            ResetToDefaults();
        }
        UI::Text("I'd recomend using the website for this TM Color Code Formatter \n(" + ColorizeString("colorizer.xjk.yt", InterpolationType::Linear, "#1DFF1A", "", true) + "), it's more user frindly and has more features.");
        if (UI::Selectable("Click HERE to open the colorizer", false)) {
            OpenBrowserURL("https://www.colorizer.xjk.yt");
        }

        UI::End();
    }
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

InterpolationType GetInterpolationTypeFromString(const string &in typeName) {
    if (typeName == "Linear") return InterpolationType::Linear;
    else if (typeName == "Quadratic") return InterpolationType::Quadratic;
    else if (typeName == "Exponential") return InterpolationType::Exponential;
    else if (typeName == "Cubic") return InterpolationType::Cubic;
    else if (typeName == "Sine") return InterpolationType::Sine;
    else if (typeName == "Back") return InterpolationType::Back;
    else if (typeName == "Elastic") return InterpolationType::Elastic;
    else if (typeName == "Bounce") return InterpolationType::Bounce;
    else if (typeName == "InverseQuadratic") return InterpolationType::InverseQuadratic;
    else if (typeName == "Smoothstep") return InterpolationType::Smoothstep;
    else if (typeName == "Smootherstep") return InterpolationType::Smootherstep;
    else if (typeName == "Circular") return InterpolationType::Circular;
    return InterpolationType::Linear;
}

void ResetToDefaults() {
    userInput = "";
    colorCode = "#FFFFFF";
    u_startColor = "#0033CC";
    u_endColor = "#33FFFF";
    includeEscapeCharacters = false;
    currentInterpolationType = InterpolationType::Linear;
}

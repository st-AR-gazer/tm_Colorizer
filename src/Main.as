bool uiVisible = false;

string userInput = "";
string colorCode = "#FFFFFF"; 
string previewText = ""; 
string u_startColor = "#0033CC";
string u_endColor = "#33FFFF";
_col::GradientMode currentGradientMode = _col::GradientMode::linear;
bool includeEscapeCharacters = true;

void RenderMenu() {
    if (UI::MenuItem("\\$1F1" + Icons::Tachometer + " " + Icons::PaintBrush + "\\$ " + _col::CS("Colorizer", {"#1DFF1A", "#FFD53D"}, _col::GradientMode::inverseQuadratic, true))) {
        uiVisible = !uiVisible;
    }
}

void RenderInterface() {
    if (!uiVisible) { return; }

    int window_flags = UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking;

    if (UI::Begin("Colorizer", uiVisible, window_flags)) {
        userInput = UI::InputText("String to be Colorized", userInput);

        string colorizedUserInput = _col::CS(userInput, {u_startColor, u_endColor}, currentGradientMode, includeEscapeCharacters);
        UI::Text("Preview: " + colorizedUserInput);
        UI::SameLine();
        if (UI::Button("Copy to Clipboard")) {
            IO::SetClipboard(colorizedUserInput);
        }

        UI::Separator();
        string currentTypeName = GetGradientModeAsString(currentGradientMode);
        if (UI::BeginCombo("Gradient Mode", currentTypeName)) {
            for (uint i = 0; i < _col::GradientMode::circular + 1; i++) {
                _col::GradientMode mode = _col::GradientMode(i);
                string modeName = GetGradientModeAsString(mode);
                bool isSelected = (currentGradientMode == mode);
                if (UI::Selectable(modeName, isSelected)) {
                    currentTypeName = modeName;
                    currentGradientMode = mode;
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

        includeEscapeCharacters = UI::Checkbox("Include Escape Characters", includeEscapeCharacters);

        if (UI::Button("Reset")) {
            ResetToDefaults();
        }

        UI::Text("I'd recommend using the website for this TM Color Code Formatter \n(" + _col::CS("colorizer.xjk.yt", {"#1DFF1A", ""}, _col::GradientMode::linear, true) + "), it's more user-friendly and has more features.");
        if (UI::Selectable("Click HERE to open the colorizer", false)) {
            OpenBrowserURL("https://www.colorizer.xjk.yt");
        }

        UI::End();
    }
}

string GetGradientModeAsString(_col::GradientMode mode) {
    switch (mode) {
        case _col::GradientMode::linear: return "Linear";
        case _col::GradientMode::exponential: return "Exponential";
        case _col::GradientMode::cubed: return "Cubed";
        case _col::GradientMode::quadratic: return "Quadratic";
        case _col::GradientMode::sine: return "Sine";
        case _col::GradientMode::back: return "Back";
        case _col::GradientMode::elastic: return "Elastic";
        case _col::GradientMode::bounce: return "Bounce";
        case _col::GradientMode::inverseQuadratic: return "InverseQuadratic";
        case _col::GradientMode::smoothstep: return "Smoothstep";
        case _col::GradientMode::smootherstep: return "Smootherstep";
        case _col::GradientMode::circular: return "Circular";
        default: return "Unknown";
    }
}

void ResetToDefaults() {
    userInput = "";
    colorCode = "#FFFFFF";
    u_startColor = "#0033CC";
    u_endColor = "#33FFFF";
    includeEscapeCharacters = false;
    currentGradientMode = _col::GradientMode::linear;
}

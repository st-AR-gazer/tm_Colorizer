bool uiVisible = false;

string userInput = "";
array<string> colors = {"#0033CC", "#33FFFF"};
_col::GradientMode currentGradientMode = _col::GradientMode::linear;
bool includeEscapeCharacters = true;
bool flippedText = false;

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

        string colorizedUserInput = _col::CS(userInput, colors, currentGradientMode, includeEscapeCharacters, flippedText);
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

        for (uint i = 0; i < colors.Length; i++) {
            string colorLabel = "Color " + (i + 1);
            colors[i] = UI::InputText(colorLabel, colors[i]);
        }

        if (UI::Button("Add Color")) {
            colors.InsertLast("#FFFFFF"); // Default new color
        }

        if (UI::Button("Remove Last Color") && colors.Length > 2) {
            colors.RemoveLast();
        }

        includeEscapeCharacters = UI::Checkbox("Include Escape Characters", includeEscapeCharacters);

        flippedText = UI::Checkbox("Flip Text", flippedText);

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
    colors = {"#0033CC", "#33FFFF"};
    includeEscapeCharacters = false;
    currentGradientMode = _col::GradientMode::linear;
}

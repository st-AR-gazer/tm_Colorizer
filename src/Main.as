[Setting name="Menu Overwrite" decription="Overwrite the condition set by export plugins to always show the colorizer UI."]
bool userMenuVisibleOverwrite = false;

bool uiVisible = false;

string userInput = "";
array<string> colors = {"#0033CC", "#33FFFF"};
_col::GradientMode currentGradientMode = _col::GradientMode::linear;
bool includeEscapeCharacters = true;
bool flippedColor = false;

void RenderMenu() {
    if (userMenuVisibleOverwrite) { menuVisible = true; }
    if (!menuVisible) { return; }
    if (UI::MenuItem("\\$1F1" + Icons::Tachometer + " " + Icons::PaintBrush + "\\$ " + _col::CS("Colorizer", {"#1DFF1A", "#FFD53D"}, _col::GradientMode::inverseQuadratic, true))) {
        uiVisible = !uiVisible;
    }
}

void RenderInterface() {
    if (!uiVisible) { return; }

    int window_flags = UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking;

    if (UI::Begin("Colorizer", uiVisible, window_flags)) {
        userInput = UI::InputText("String to be Colorized", userInput);

        string colorizedUserInput = _col::CS(userInput, colors, currentGradientMode, includeEscapeCharacters, flippedColor);
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
            UI::SameLine();
            if (UI::Button("Delete##" + i)) {
                if (colors.Length > 1) {
                    colors.RemoveAt(i);
                }
            }
        }

        if (UI::Button("Add Color")) {
            colors.InsertLast("#FFFFFF");
        }

        includeEscapeCharacters = UI::Checkbox("Include Escape Characters", includeEscapeCharacters);

        flippedColor = UI::Checkbox("Flip Text", flippedColor);

        if (UI::Button("Reset")) {
            ResetToDefaults();
        }

        UI::Text("I'd recommend using the website for this TM Color Code Formatter, it's a bit better imo (and it can be used without having TM open which is nice).");
        if (UI::Selectable(_col::CS("colorizer.xjk.yt", {"#0000EE", "#1010FE"}, _col::GradientMode::linear, true), false)) {
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
    flippedColor = false;
}
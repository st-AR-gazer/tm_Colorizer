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
    if (expotOnlyMode) { return; }

    if (!uiVisible) { return; }

    int window_flags = UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize | UI::WindowFlags::NoDocking;

    if (UI::Begin("Colorizer", uiVisible, window_flags)) {
        UI::Text("Preview: " + colorizedUserInput);

        UI::Separator();

        if(UI::Button("Colorize")) { // send to bottom
            ColorizeString("Colorizer", InterpolationType::Linear, startColor, endColor);
        }
        
        UI::Separator();

        UI::InputInt("Start Color", t_startColor);
        UI::SameLine();
        UI::InputInt("End Color", t_endColor);
        

        UI::InputText("Filename", );


        if (UI::Button("Does the dragonyeet hit the glass?")) { 
            if (classificationDoesHitRoof == true) { 
                classificationDoesHitRoof = false; 
            } else { 
                classificationDoesHitRoof = true; 
            } 
        }
        if (classificationDoesHitRoof == true) {
            UI::Text("The dragonyeet " + "\\$0f0" + "DOES "     + "\\$z" + "hit the glass");
        } else {
            UI::Text("The dragonyeet " + "\\$f00" + "DOES NOT " + "\\$z" + "hit the glass");
        }

        UI::Text("Current filename: `" + filename + "`");

        UI::Separator();
        
        if (startFileEnabled) {
            UI::BeginDisabled();
            if (UI::Button("Start Recording (file)")) { StartRecording(filename, classificationDoesHitRoof); startFileEnabled = false; }
            UI::EndDisabled();
            UI::SameLine();
            if (UI::Button("Stop Recording (file)")) { StopRecording(); startFileEnabled = true; }
        } else {
            if (UI::Button("Start Recording (file)")) { StartRecording(filename, classificationDoesHitRoof); startFileEnabled = false; }
            UI::SameLine();
            UI::BeginDisabled();
            if (UI::Button("Stop Recording (file)")) { StopRecording(); startFileEnabled = true; }
            UI::EndDisabled();
        }

        UI::Separator();

        UI::BeginDisabled();
        if (UI::Button("Open Socket")) { openSocket(); }
        UI::SameLine(); 
        if (UI::Button("Close Socket")) { closeSocket(); }

        if (UI::Button("Close Resoueces")) { closeResources(); }
        UI::EndDisabled();
        UI::End();
    }





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

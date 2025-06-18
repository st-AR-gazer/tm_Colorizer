
bool g_ShowWindow = false;
string g_Input = "Colourful text!";
array<string> g_Palette = { "5cf", "fab", "fff", "fab", "5cf" };

Colorizer::GradientMode g_Mode = Colorizer::GradientMode::linear;
bool g_UseEsc  = true;
bool g_FlipPal = false;

vec3 HexToVec3(const string &in hex) {
    string s = hex.StartsWith("#") ? hex.SubStr(1) : hex;
    if (s.Length == 3) s = s.SubStr(0, 1) + s.SubStr(0, 1) + s.SubStr(1, 1) + s.SubStr(1, 1) + s.SubStr(2, 1) + s.SubStr(2, 1);
    uint v = Text::ParseUInt(s, 16);
    return vec3(((v >> 16) & 0xFF) / 255.0f, ((v >> 8) & 0xFF) / 255.0f, (v & 0xFF) / 255.0f);
}

string Vec3ToHex(const vec3 &in c) {
    uint r = uint(Math::Clamp(int(c.x * 255.0f + 0.5f), 0, 255));
    uint g = uint(Math::Clamp(int(c.y * 255.0f + 0.5f), 0, 255));
    uint b = uint(Math::Clamp(int(c.z * 255.0f + 0.5f), 0, 255));
    const string HEX="0123456789ABCDEF";
    return "#" + HEX.SubStr(r >> 4, 1) + HEX.SubStr(r & 15, 1)+
                 HEX.SubStr(g >> 4, 1) + HEX.SubStr(g & 15, 1)+
                 HEX.SubStr(b >> 4, 1) + HEX.SubStr(b & 15, 1);
}

bool uiVisible = true;
bool menuVisible = true;

void RenderMenu() {
    if (!uiVisible || !menuVisible) return;

    if (UI::MenuItem(Colorize(Icons::PaintBrush + " Colorizer", g_Palette, g_Mode, g_UseEsc, g_FlipPal), "", g_ShowWindow)) g_ShowWindow = !g_ShowWindow;
}

void RenderInterface() {
    if (!uiVisible || !menuVisible) return;

    if (!g_ShowWindow) return;

    const int flags = UI::WindowFlags::NoCollapse | UI::WindowFlags::AlwaysAutoResize;

    if (!UI::Begin("Colorizer", g_ShowWindow, flags)) { UI::End(); return; }

    g_Input = UI::InputText("##input", g_Input);
    UI::SeparatorText("");
    string preview = Colorize(g_Input, g_Palette, g_Mode, g_UseEsc, g_FlipPal);
    UI::Text(preview);

    UI::Separator();
    if (UI::Button(Icons::Clipboard + " Copy")) IO::SetClipboard(preview);

    UI::SameLine();
    if (UI::Button(Icons::Undo + " Reset")) {
        g_Input   = "Colourful text!";
        g_Palette = { "5cf", "fab", "fff", "fab", "5cf" };
        g_Mode    = Colorizer::GradientMode::linear;
        g_UseEsc  = true;
        g_FlipPal = false;
    }

    UI::SameLine(); g_FlipPal = UI::Checkbox("Flip palette", g_FlipPal);
    UI::SameLine(); g_UseEsc  = UI::Checkbox("Preview uses GB (overlay)", g_UseEsc);

    UI::Separator();
    UI::Columns(2, "cols", false);

    UI::Text("Palette");
    for (uint i = 0; i < g_Palette.Length; ++i) {
        UI::PushID(int(i));
        vec3 col = HexToVec3(g_Palette[i]);
        col = UI::InputColor3("##col", col);
        g_Palette[i] = Vec3ToHex(col);
        UI::SameLine();
        if (UI::Button(Icons::Times)) {
            if (g_Palette.Length > 2) g_Palette.RemoveAt(i);
            UI::PopID();
            continue;
        }
        UI::PopID();
    }
    if (UI::Button(Icons::Plus + " Add colour")) g_Palette.InsertLast("#FFFFFF");

    UI::NextColumn();

    UI::Text("Gradient mode");
    for (uint i = 0; i <= Colorizer::GradientMode::circular; ++i) {
        Colorizer::GradientMode m = Colorizer::GradientMode(i);
        if (UI::RadioButton(tostring(m), g_Mode == m)) g_Mode = m;
    }

    UI::Columns(1);
    UI::End();
}

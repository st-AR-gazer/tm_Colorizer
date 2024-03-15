string FormatColorCode(const string &in hexColor) {
    int r, g, b;
    HexToRgb(hexColor, r, g, b);

    string rHex = Text::Format("%1X", r / 17);
    string gHex = Text::Format("%1X", g / 17);
    string bHex = Text::Format("%1X", b / 17);

    string formattedColor = includeEscapeCharacters ? "\\$" : "$";
    formattedColor += rHex + gHex + bHex;

    return formattedColor;
}

string ColorizeString(const string &in inputString, InterpolationType type) {
    if (inputString.Length < 2) return FormatColorCode(startColorGlobal) + inputString;

    array<string> colors = InterpolateColors(inputString.Length, type);
    string coloredString;

    for (uint i = 0; i < inputString.Length; ++i) {
        string colorCode = FormatColorCode(colors[i]);
        string characterAsString = inputString.SubStr(i, 1);
        coloredString += colorCode + characterAsString;
    }

    return coloredString;
}

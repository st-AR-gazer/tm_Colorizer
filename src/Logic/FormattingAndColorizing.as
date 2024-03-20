string FormatColorCode(const string &in hexColor, bool includeEscapeCharacters) {
    int r, g, b;
    HexToRgb(hexColor, r, g, b);

    string rHex = Text::Format("%1X", r / 17);
    string gHex = Text::Format("%1X", g / 17);
    string bHex = Text::Format("%1X", b / 17);

    string formattedColor = includeEscapeCharacters ? "\\$" : "$";
    formattedColor += rHex + gHex + bHex;

    return formattedColor;
}

string ColorizeString(const string &in inputString, InterpolationType type, string t_startColor = "#0033CC", string t_endColor = "#33FFFF", bool includeEscapeCharacters = false) {
    if (t_startColor == "") { t_startColor = "#0033CC"; }
    if (t_endColor == "")   { t_endColor =   "#33FFFF"; }

    if (inputString.Length < 2) return FormatColorCode(startColorGlobal, includeEscapeCharacters) + inputString;

    array<string> colors = InterpolateColors(inputString.Length, type, t_startColor, t_endColor);
    string coloredString;

    for (uint i = 0; i < inputString.Length; ++i) {
        string colorCode = FormatColorCode(colors[i], includeEscapeCharacters);
        string characterAsString = inputString.SubStr(i, 1);
        coloredString += colorCode + characterAsString;
    }

    return coloredString + (includeEscapeCharacters ? "\\$z" : "$z");
}

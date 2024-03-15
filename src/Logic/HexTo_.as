int HexToInt(const string &in hex) {
    int value = 0;
    for (uint i = 0; i < hex.Length; ++i) {
        value *= 16;
        int charValue = hex[i];
        if (charValue >= 48 && charValue <= 57) { // '0' to '9'
            value += charValue - 48;
        } else if (charValue >= 65 && charValue <= 70) { // 'A' to 'F'
            value += 10 + (charValue - 65);
        } else if (charValue >= 97 && charValue <= 102) { // 'a' to 'f'
            value += 10 + (charValue - 97);
        } else {
            log("Invalid character in hex string: " + hex[i], LogLevel::Error, 74);
            return -1;
        }
    }
    return value;
}

void HexToRgb(const string &in hex, int &out r, int &out g, int &out b) {
    r = HexToInt(hex.SubStr(1, 2));
    g = HexToInt(hex.SubStr(3, 2));
    b = HexToInt(hex.SubStr(5, 2));
}
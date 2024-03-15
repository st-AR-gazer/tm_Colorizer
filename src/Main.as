void Main() {
    test();
}

void test() {
    InterpolationType interpolationType = InterpolationType::Quadratic;

    string testString = "Altered";
    string coloredString = ColorizeString(testString, interpolationType);
    string testString2 = "Nadeo!";
    string coloredString2 = ColorizeString(testString2, interpolationType);
    
    log(coloredString + " " + coloredString2, LogLevel::Info);
}

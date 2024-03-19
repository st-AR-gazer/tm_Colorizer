string Colorize(string str, InterpolationType type = InterpolationType::Linear, string t_startColor = "#0033CC", string t_endColor = "#33FFFF") {
   string opt_str = ColorizeString(str, type, t_startColor, t_endColor);
   return opt_str;
}

string ColorizeNEO(string str, InterpolationType type = InterpolationType::Linear, string t_startColor = "#0033CC", string t_endColor = "#33FFFF", bool t_neo = true) {
   if (!t_neo) { return ""; } 
   string opt_str = ColorizeString(str, type, t_startColor, t_endColor);
   return opt_str;
}

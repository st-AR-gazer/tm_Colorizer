string Colorize(const string &in str, InterpolationType type = InterpolationType::Linear, const string &in t_startColor = "#0033CC", const string &in t_endColor = "#33FFFF") {
   string opt_str = ColorizeString(str, type, t_startColor, t_endColor);
   return opt_str;
}

string ColorizeNEO(const string &in str, InterpolationType type = InterpolationType::Linear, const string &in t_startColor = "#0033CC", const string &in t_endColor = "#33FFFF", bool t_neo = true) {
   if (!t_neo) { return str; } 
   string opt_str = ColorizeString(str, type, t_startColor, t_endColor);
   return opt_str;
}

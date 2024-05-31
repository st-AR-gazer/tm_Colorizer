string Colorize(const string &in str, const array<string> &in colors = {"0033CC", "33FFFF"}, _col::GradientMode type = _col::GradientMode::linear, bool useEscapeCharacters = true, bool flipped = false, bool _verbose = false) {
   string opt_str = _col::CS(str, colors, type, useEscapeCharacters, flipped, _verbose);
   return opt_str;
}
string Colorize(array<string> astr, const array<string> &in colors = {"0033CC", "33FFFF"}, _col::GradientMode type = _col::GradientMode::linear, bool useEscapeCharacters = true, bool flipped = false, bool _verbose = false) {
   string opt_str = _col::CS(astr, colors, type, useEscapeCharacters, flipped, _verbose);
   return opt_str;
}

void HideColorizerUI(bool t_neo = true) {
   if (t_neo) {
      uiVisible = false;
      menuVisible = false;
   } else {
      uiVisible = true;
      menuVisible = true;
   }  
}
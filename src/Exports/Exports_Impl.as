string Colorize(const string &in str, _col::GradientMode type = _col::GradientMode::linear, const array<string> &in colors = {"0033CC", "33FFFF"}) {
   string opt_str = _col::CS(str, colors, type);
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
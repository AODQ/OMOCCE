import engine;
import global;

struct Om_Char {
  dchar value;

  this ( dchar value_ ) {
    value = value_;
  }
}

struct Om_Out_String {
  string value;

  this ( string value_ ) {
    value = value_;
  }
}

Om_Char[] To_Om_Char ( string value ) {
  import functional;
  return value.map!(n => Om_Char(n)).array;
}

class Om_String {
  Om_Char[] tokens;

  this ( Om_Char[] tokens_ ) {
    tokens = tokens_;
  }
  this ( string value ) {
    import functional;
    tokens = value.map!(n => Om_Char(n)).array;
  }
}

Om_Out_String Concatenate_String ( Om_Char[] chars, int x, int w ) {
  import std.stdio;
  size_t i, last_space;
  for ( ; i < w - x; ++ i ) {
    if ( chars.length <= i ) break;
    if ( chars[i].value == '\n' ) break;
    if ( chars[i] == ' ' ) last_space = i;
  }
  return Om_Out_String(chars[0 .. last_space]);
}

import window;

void Output ( Window window, Om_String str ) {
  terminal.layer(window.layer);
  terminal.crop(window.x, window.y, window.width, window.height);
  terminal.clear_area(0, 0, 80, 26);
  int w = window.x, h = window.y;
  import std.stdio;
  if ( window.alignment == Alignment.middle )
    w = window.x + (window.x + window.width)/2 - cast(int)str.tokens.length/2;

  for ( int it = 0; it < str.tokens.length; ++ it ) {
    if ((window.wrap && w >= window.width + window.x) || str.tokens[it].value == '\n' ) {
      w = window.x;
      h += 1;
      if ( h >= window.height + window.y ) return;
    }
    auto out_str = Concatenate_String(str.tokens[it .. $], w, window.x + window.width);
    terminal.print(w, h, out_str.value);
    w += out_str.value.length;
    it += out_str.value.length;
  }
}

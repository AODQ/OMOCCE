import engine;
import global;

struct OMChar {
  dchar value;

  this ( dchar value_ ) {
    value = value_;
  }
}

struct OMOutString {
  string value;
  bool newline;

  this ( string value_, bool newline_ = false ) {
    value = value_;
    newline = newline_;
  }

  this ( OMChar[] chars, bool newline_ = false ) {
    import functional;
    this(chars.map!(n => n.value).array.to!string, newline_);
  }
}

OMChar[] To_OMChar ( string value ) {
  import functional;
  return value.map!(n => OMChar(n)).array;
}

alias OMChar[] OMString;

auto CreateOMString ( string value ) {
  import functional;
  return value.map!(n => OMChar(n)).array;
}

import window;

void Output ( inout Window window, OMString str ) {
  auto info = window.RWindow_Info;
  terminal.layer(info.layer);
  terminal.crop(info.start_x, info.start_y, info.width, info.height);
  terminal.clear_area(0, 0, 80, 26);
  import std.stdio;

  for ( int it, y; it < str.length || y >= info.height; ++ y) {
    auto out_str = window.Format_String(str, info, it);
    terminal.print(info.start_x, y, out_str.value);
  }
}

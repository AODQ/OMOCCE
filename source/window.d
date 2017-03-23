module window;
import engine;

enum Alignment { left, middle, right }

struct WindowInfo {
  string name;
  int start_x, start_y, end_x, end_y, width, height;
  int layer;
  bool text_wrap;
  Alignment alignment;
}

class Window {
public:
  WindowInfo info;
  this ( WindowInfo info_ ) {
    info = info_;
    info.width  = info.end_x - info.start_x;
    info.height = info.end_y - info.start_y;
  }

  WindowInfo RWindow_Info() const { return info; }
  OMOutString Format_String(inout OMString, inout WindowInfo, ref int);
}

class OutputLogWindow : Window {
public:
  this ( WindowInfo info_ ) {
    super(info_);
  }
  override OMOutString Format_String(inout OMString str, inout WindowInfo info,
                                     ref int it) const in {
    assert(start <= end);
    assert(str.length > 0);
    assert(it >= 0 && it < str.length);
  }  body  {
    return OMString(str[0 .. $]);
  }

}



// x = window.x + (window.x + window.width)/2 - cast(int)str.tokens.length/2;

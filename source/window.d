module window;

enum Alignment { left, middle, right }

struct Window {
  string name;
  int x, y, width, height, layer;
  bool border, wrap;
  Alignment alignment;
  this ( string name_, int x_, int y_, int width_, int height_, int layer_,
         bool border_ = false, bool wrap_ = false,
         Alignment alignment_ = Alignment.left) {
    name = name_; x = x_; y = y_;
    width = width_; height = height_;
    wrap = wrap_;
    layer = layer_; border = border_; alignment = alignment_;
  }
}

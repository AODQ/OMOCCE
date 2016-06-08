module OMOCCE.Position;

class Position {
  ushort x, y;
  ubyte z;
  ubyte location;
public:
  this() {}
  this(ushort _x, ushort _y, ubyte _z, ubyte _location) {
    x = _x; y = _y; z = _z; location = _location;
  }
  void Set(ushort _x, ushort _y) { x = _x; y = _y; }
  void Set(ushort _x, ushort _y, ubyte _z) { x = _x; y = _y; z = _z; }
  void Set(ushort _x, ushort _y, ubyte _z, ubyte _location) {
    if ( location != _location ) {
      
    }
    x = _x; y = _y; z = _z; location = _location;
  }

  ushort R_X() const { return x; }
  ushort R_Y() const { return y; }
  ubyte  R_Z() const { return z; }
  ubyte  R_Loc() const { return location; }
}

module OMOCCE.Entities.DisplayableEntity;
import OMOCCE.Entities.Entity;
import OMOCCE.ConsoleUtility : colour;
import OMOCCE.Position;

class DisplayableEntity : Entity {
  char symbol;
  ubyte symbol_bg, symbol_fg;
  immutable(char)* portrait;
  Position position;
public:
  this(uint _id, string _name, char _symbol, Position _position,
       colour _sym_fg = colour.white, colour _sym_bg = colour.black,
       immutable(char)* _portrait = null) {
    super(_id, _name);
    portrait = _portrait;
    symbol = _symbol;
    symbol_bg = cast(ubyte)_sym_bg;
    symbol_fg = cast(ubyte)_sym_fg;
    position = new Position(0, 0, 0, 0);
    position.Set(_position);
  }

  char R_Symbol() { return symbol; }
  Position* R_Position() { return &position; }
  colour R_Symbol_FG_Colour() { return cast(colour)symbol_fg; }
  colour R_Symbol_BG_Colour() { return cast(colour)symbol_bg; }
}
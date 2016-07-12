module OMOCCE.Entities.BaseAI;
import OMOCCE.Entities.DisplayableEntity;
import OMOCCE.Position;
import OMOCCE.ConsoleUtility : colour;

class BaseAI : DisplayableEntity {
public:
  this(uint _id, string _name, char _symbol, Position _position,
       colour _sym_fg = colour.white, colour _sym_bg = colour.black,
       immutable(char)* _portrait = null ) {
    super(_id, _name, _symbol, _position, _sym_fg, _sym_bg, _portrait);
  }

  void Update() {
    auto dx = uniform(-1, 2);
    auto dy = uniform(-1, 2);
    
    position.Set(position.R_X() + dx, position.R_Y() + dy);
  }
}

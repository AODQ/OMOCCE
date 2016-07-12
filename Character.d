module OMOCCE.Entities.Character;
import OMOCCE.Position;
import OMOCCE.Entities.DisplayableEntity;

class Character : DisplayableEntity {
public:
  this(uint _id, Position pos) {
    super(_id, "", '@', pos);
  }
  /*
  void Create(ref string _name, char _symbol, ref string _portrait,
              ref Position _pos, uint _id) {
    name = _name.dup();
    symbol = _symbol;
    portrait = _portrait.ptr;
    position = _pos;
    id = _id;
  }*/

}
module OMOCCE.Character;
import OMOCCE.Position;
import OMOCCE.Entity;

class Character : public Entity {
  char symbol;
  immutable(char)* portrait;
  Position position;
public:
  void Create(ref string _name, char _symbol, ref string _portrait,
              ref Position _pos, uint _id) {
    name = _name.dup();
    symbol = _symbol;
    portrait = _portrait.ptr;
    position = _pos;
    id = _id;
  }

  int R_ID() { return id; }
  
}
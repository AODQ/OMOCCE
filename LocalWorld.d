module OMOCCE.LocalWorld;
import OMOCCE.Character;
import OMOCCE.Entity;

class LocalWorld : public Entity {
  Character[int] local_characters; 
public:
  this(byte _id, ref string _name) {
    id = _id;
    name = _name.dup();
  }

  void Add_Local_Character(ref Character character) {
    local_characters[character.R_ID()] = character;
  }
  void Rem_Local_Character(ref Character character) {
    local_characters.remove(character.R_ID());
  }
}
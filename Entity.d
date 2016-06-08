module OMOCCE.Entity;

class Entity {
  uint ID;
  string name;
public:
  this(uint _ID) { ID = _ID; name = ""; }
  this(uint _ID, ref string _name) { ID = _ID; name = _name; }
}
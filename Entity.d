module OMOCCE.Entities.Entity;

class Entity {
protected:
  uint id;
  string name;
public:
  this(uint _ID) { id = _ID; name = ""; }
  this(uint _ID, ref string _name) { id = _ID; name = _name.dup(); }

  string R_Name() { return name; }
  uint R_ID() { return id; }
}

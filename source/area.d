module area;


Area[] locations;

class Area {
  string name, description;
public:
  this ( string name_, string description_ ) {
    name        = name_;
    description = description_;
  }

  string RName ( ) { return name; }
  string RDescription ( ) { return description; }
}

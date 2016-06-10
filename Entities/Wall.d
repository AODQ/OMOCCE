module OMOCCE.Entities.Wall;
import OMOCCE.Entities.DisplayableEntity;
import OMOCCE.ConsoleUtility : colour;
import OMOCCE.Position;

class Wall : DisplayableEntity {

public:
  this(Position pos) {
    super(0, "", '#', pos, colour.black, colour.white);
  }
}
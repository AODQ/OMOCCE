module OMOCCE.LocalWorld;
import OMOCCE.Entities.Character;
import OMOCCE.Entities.Entity;
import OMOCCE.Entities.DisplayableEntity;
import OMOCCE.Position;
import ConsUtil = OMOCCE.ConsoleUtility : colour;

class LocalWorld : Entity {
  DisplayableEntity[][][] entities;
  int width, height;
public:
  this(string _name) {
    super(0, _name);
    import OMOCCE.Entities.Wall;
    entities.length = 100;
    foreach ( x; 0 .. 100 ) {
      entities[x].length = 100;
    }
    width  = entities.length;
    height = entities[0].length;
    foreach ( x; 20 .. 80 ) {
      entities[x][ 5] ~= new Wall(new Position(0, 0, 0, 0));
      entities[x][30] ~= new Wall(new Position(0, 0, 0, 0));
    }
    foreach ( x; 5 .. 31 ) {
      entities[19][x] ~= new Wall(new Position(0, 0, 0, 0));
      entities[80][x] ~= new Wall(new Position(0, 0, 0, 0));
    }
    entities[44][17] ~= new Character(0, new Position(0, 0, 0, 0));
  }

  void Display_Map(short px, short py) {
    ConsUtil.Draw_Box(1, 1, 98, 35, ConsUtil.colour.black);
    int dx = px - 98/2, dy = py - 34/2;
    if ( dx < 0 ) dx = 0;
    if ( dy < 0 ) dy = 0;
    int dxl = 98+dx, dxy = 35+dy;
    if ( dxl > width  ) dxl = width;
    if ( dxy > height ) dxy = height;
    foreach ( x; dx .. dxl ) {
      foreach ( y; dy .. dxy ) {
        if ( entities[x][y].length > 0 ) {
          DisplayableEntity entity = entities[x][y][$-1];
          ConsUtil.Draw_Tile(entity.R_Symbol(), x + 1, y + 1,
                             entity.R_Symbol_FG_Colour(),
                             entity.R_Symbol_BG_Colour());
        }
      }
    }
  }
}

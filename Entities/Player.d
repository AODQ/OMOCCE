module OMOCCE.Entities.Player;
import OMOCCE.Position;
import OMOCCE.Entities.Character;
import OMOCCE.GlobalWorld;

class Player : Character {
public:
  this(uint _id, Position pos) {
    super(_id, pos);
  }

  void Display_Statistics() {
    import CUtil = OMOCCE.ConsoleUtility : colour;
    uint x = 100, y = 1;
    CUtil.Draw_Box(x, y, 19, 35, colour.red);
    //CUtil.Output(R_Name(), x+1, y+1, colour.white, colour.black);
    /*
    string loc_str = GlobalWorld.R_Local_World(R_Position().R_Loc()).R_Name();
    CUtil.Output(loc_str, x+1, y+3, colour.white, colour.black);*/
  }
}
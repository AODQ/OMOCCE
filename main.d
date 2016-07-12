import std.stdio;
import std.conv : to;
import ConsoleUtil = OMOCCE.ConsoleUtility : colour, Output;
import OMOCCE.Dialogue;
import Menu = OMOCCE.Menu;
import ArtGen = OMOCCE.ArtGenerator;
import OMOCCE.GlobalWorld;
import OMOCCE.LocalWorld;
import OMOCCE.Entities.Player;
import OMOCCE.Position;
  
void Exit() {
  ConsoleUtil.Clear_Screen(colour.black);
  int x = 40, y = 25, w = 18, h = 2;
  ConsoleUtil.Draw_Box(x, y, w, h, colour.white, colour.gray, true);
  ConsoleUtil.Output("THANKS FOR PLAYING", x+1, y+1,
                          colour.black, colour.gray);
}

int main(string[] argv) {
  ConsoleUtil.Initialize_Window();
  Print_Interface();
  auto local_world = new LocalWorld("cool map");
  GlobalWorld.Add_Local_World(local_world);
  local_world.
  local_world.Display_Map(5, 5);
  auto p = new Player(0, new Position(0, 0, 0, 0));
  p.Display_Statistics();

  ConsoleUtil.Pause_Input();
  Exit();
  return 0;
}

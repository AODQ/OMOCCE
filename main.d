import std.stdio;
import std.conv : to;
import ConsoleUtil = OMOCCE.ConsoleUtility : colour, Output;
import OMOCCE.Dialogue;
import Menu = OMOCCE.Menu;
import ArtGen = OMOCCE.ArtGenerator;


void Exit() {
  ConsoleUtil.Clear_Screen(colour.black);
  int x = 40, y = 25, w = 18, h = 2;
  ConsoleUtil.Draw_Box(x, y, w, h, colour.white, colour.gray, true);
  ConsoleUtil.Output("THANKS FOR PLAYING", x+1, y+1,
                          colour.black, colour.gray);
}


int main(string[] argv) {
  ConsoleUtil.Initialize_Window();
  //ArtGen.Create_Art();

  Menu.Initialize();
  Intro();
  Character_Creation();

  Exit();
  ConsoleUtil.Pause_Input();
  return 0;
}
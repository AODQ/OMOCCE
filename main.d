import std.stdio;
import std.conv : to;
import ConsoleUtil = OMOCCE.ConsoleUtility : console_colour, Output;
import OMOCCE.Dialogue;


int main(string[] argv) {
  ConsoleUtil.Initialize_Window();
  Intro();
  Character_Creation();
  ConsoleUtil.Pause_Input();
  return 0;
}
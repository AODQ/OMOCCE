module OMOCCE.Menu;
import ConsolUtil = OMOCCE.ConsoleUtility : colour;
import OMOCCE.Dialogue;
void Initialize() {
  auto bg_col = colour.dark_blue;
  auto txt_col = colour.white;
  ConsolUtil.Clear_Screen(colour.black);
  ConsolUtil.Draw_Box(10, 5, 128-20-10, 40, colour.purple, bg_col, false);
  ConsolUtil.Output("╬ New game",  22, 41, txt_col, bg_col);
  ConsolUtil.Output("  Load game", 22, 43, txt_col, bg_col);
  ConsolUtil.Output("  Options",   52, 43, txt_col, bg_col);
  ConsolUtil.Output("  Credits",   82, 41, txt_col, bg_col);
  ConsolUtil.Output("  Quit",      82, 43, txt_col, bg_col);

  Print_Menu_Title_Art(txt_col, bg_col);

  ConsolUtil.Pause_Input();
  ConsolUtil.Clear_Screen(colour.black);
  ConsolUtil.Reset_Cursor();
}
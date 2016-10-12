import std.string : toStringz;
import deimos.ncurses.curses;
import ConsoleUtil.Window;
import ConsoleUtil.Message;

WINDOW* create_new_window(int height, int width, int y, int x) {
  WINDOW* win = newwin(height, width, y, x);
  box(win, 0, 0);
  wrefresh(win);
  return win;
}

void destroy_win(WINDOW* win) {
  wrefresh(win);
  delwin(win);
}

void Sleep(int ms) {
  import core.thread;
  Thread.sleep ( dur!("msecs")(ms) );
}
void Out(string x) {
  // Thread.sleep( dur!("msecs")(150) );
  // Output_Message(new Message(x));
  // refresh();
}

void main() {
  Init();
  scope (exit)
    endwin();
  scope (failure)
    endwin();

  refresh();
  auto win = new MainWindow();
  win.Refresh();

  auto twin = new TimeWindow();
  twin.Refresh();
  auto status = new StatusBarWindow();
  status.Refresh();
  auto map = new MapWindow();
  map.Refresh();
  auto inp = new InputWindow();
  inp.Refresh();
  auto portrait = new PortraitWindow();
  portrait.Refresh();
  auto pportrait = new PartyWindow();
  pportrait.Refresh();
  auto auc = new AutoCompleteWindow();
  auc.Refresh();
  getch();
}

module ConsoleUtil.Window;
import deimos.ncurses.curses;
import std.string;
import Data = Data.Window;
import ConsoleUtil.Message;
import ConsoleUtil.Debug;

static immutable(int) Console_height = 50;

enum Type {
  Main, StatusBar, Map
};


class Window {
  Type type;
  WINDOW* window;
  int width, height, x, y;
public:
  this (Type t, int _height, int _width, int _y, int _x) {
    type = t;
    width  = _width;
    height = _height;
    x = _x; y = _y;
    window = newwin(height, width, y, x);
    box(window, 0, 0);
  }
  // ~this() {
  //   wborder(window, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
  //   wrefresh(window);
  //   delwin(window);
  // }
  void Refresh() {
    if ( LINES != width || COLS != height ) {
      wresize(window, height, width);
    }
    wrefresh(window);
  }
  int R_Width()  { return width;  }
  int R_Height() { return height; }
  int R_X()      { return x;      }
  int R_Y()      { return y;      }
}


class MainWindow : Window {
public:
  this() {
    getmaxyx(stdscr, height, width);
    height -= 3;
    super(Type.Main, height, width, 2, 0);
  }

  override void Refresh() {
    mvwprintw(window, 1, 1,
    "A small oasis town in the middle of this "
    "wasteland continent. Although no star");
    mvwprintw(window, 2, 1,
    "shines in the region of Asgaratha, "
    "your surroundings are lit by a dim blue");
    mvwprintw(window, 3, 1,
    "light. Everything from pathways to the "
    "towers scraping the low-hanging fog and");
    mvwprintw(window, 4, 1,
    "even their surrounding hovels are made "
    "of a material.");
    mvwprintw(window, 5, 1,
    "There is a sloth-creature with several horns playing in the sand");
    mvwprintw(window, 6, 1,
    "Jez the Great Ox Merchant is walking towards the west");
    mvwprintw(window, 7, 1,
    "Peal the Forsaken is hiding in the shadows");
    mvwprintw(window, 8, 1,
    "You see Jez the Great Ox Merchant change movement to the south");
    mvwprintw(window, 9, 1,
    "Manuel enters from a nearby hovel");
    mvwprintw(window, 10, 1,
    "Jez the Great Ox Merchant has exitted to the south");
    mvwprintw(window, 11, 1,
    "A man in robes approaches you and asks to see your identity");
    mvwprintw(window, 12, 1,
    ">> look man <in robes>");
    mvwprintw(window, 13, 1,
    "You see a tired, old ...");
    super.Refresh();
  }
}

class StatusBarWindow : Window {
  public:
  this() {
    getmaxyx(stdscr, height, width);
    height = 3;
    super(Type.StatusBar, height, width, 0, 0);
  }

  override void Refresh() {
    mvwprintw(window, 1, 1, "HP: 150 Gold: 180 Status: sitting");
    super.Refresh();
  }
}

class InputWindow : Window {
  public:
  this() {
    getmaxyx(stdscr, y, width);
    width -= 39;
    super(Type.StatusBar, 3, width, y-4, 0);
  }

  override void Refresh() {
    mvwprintw(window, 1, 1, ">> give identity <to> ma");
    super.Refresh();
  }
}

class MapWindow : Window {
  public:
  this() {
    getmaxyx(stdscr, y, x);
    width = 60;
    height = 15;
    super(Type.Map, height, width, 0, x-width);
  }

  override void Refresh() {
    mvwprintw(window, 1, 1, "    MAP   ");
    mvwprintw(window, 2, 1, " *---.  .-");
    mvwprintw(window, 4, 1, "     |--| ");
    mvwprintw(window, 5, 1, "        ' ");
    super.Refresh();
  }
}

class PartyWindow : Window {
  public:
  this() {
    getmaxyx(stdscr, y, x);
    width = 60;
    super(Type.Map, y-15*2-1, width, 14, x-width);
  }

  override void Refresh() {
    mvwprintw(window, 1, 1, "    PARTY   ");
    mvwprintw(window, 2, 1, "AoD: stats... blah blah ");
    mvwprintw(window, 6, 1, "Peal: stats... blah blah ");
    super.Refresh();
  }
}

class AutoCompleteWindow : Window {
  public:
  this() {
    getmaxyx(stdscr, y, x);
    super(Type.Map, 4, 16, y-7, 25);
  }

  override void Refresh() {
    mvwprintw(window, 1, 1, "man <in robes>");
    mvwprintw(window, 2, 1, "manuel");
    super.Refresh();
  }
}


class TimeWindow : Window {
  public:
  this() {
    getmaxyx(stdscr, y, x);
    width = 15;
    height = 15;
    super(Type.Map, height, width, y-height-3, x-58);
  }

  override void Refresh() {
    wborder(window, ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ');
    mvwprintw(window, 1 , 1, "      /\\MOVE  ");
    mvwprintw(window, 2 , 1, "     /  \\TIMER");
    mvwprintw(window, 3 , 1, "    /    \\    ");
    mvwprintw(window, 4 , 1, "   /     /\\   ");
    mvwprintw(window, 5 , 1, "  /     /  \\  ");
    mvwprintw(window, 6 , 1, " /     |    \\ ");
    mvwprintw(window, 7 , 1, "/    /\\'    / ");
    mvwprintw(window, 8 , 1, "\\    \\/    / ");
    mvwprintw(window, 9 , 1, " \\        /   ");
    mvwprintw(window, 10, 1, "  \\      /    ");
    mvwprintw(window, 11, 1, "   \\    /     ");
    mvwprintw(window, 12, 1, "    \\  /      ");
    mvwprintw(window, 13, 1, "     \\/       ");
    super.Refresh();
  }
}

class PortraitWindow : Window {
  public:
  this() {
    getmaxyx(stdscr, y, x);
    width = 40;
    height = 17;
    super(Type.Map, height, width, y-height-1, x-width);
  }

  override void Refresh() {
    mvwprintw(window, 1 , 1, "  CHARACTER PORTRAIT ");
    mvwprintw(window, 2 , 1, "  ......  __   ....  ");
    mvwprintw(window, 3 , 1, "   ..... |--| ...    ");
    mvwprintw(window, 4 , 1, "      / ';||/'       ");
    mvwprintw(window, 5 , 1, "     .   ' |% .      ");
    mvwprintw(window, 6 , 1, "    '    |  . .      ");
    mvwprintw(window, 7 , 1, "     '  =  .         ");
    mvwprintw(window, 8 , 1, "      ;;=;           ");
    mvwprintw(window, 9 , 1, "       '             ");
    mvwprintw(window, 10, 1, "                     ");
    super.Refresh();
  }
}
import std.traits;
void Print(X, Y)(X x, Y y, string n) if ( isIntegral!X && isIntegral!Y) {
  mvprintw(cast(int)x, cast(int)y, "%s", n.toStringz);
}

void Clear_Screen() {
  erase();
}

void Init() {
  initscr();
  noecho();
  raw();
  keypad(stdscr, true);
  // Draw_Window();
}

// void Draw_Window() {
//   Print(0, 0, Data.layout[Data.LayoutType.standard_top]);
//   foreach ( n; 1 .. Console_height - 1 )
//     Print(n, 0, Data.layout[Data.LayoutType.standard_mid]);
//   Print(Console_height-1, 0, Data.layout[Data.LayoutType.standard_bot]);
// }


private void Word_Wrap (ref ConsoleString cons_str) {
  int i = 0;
  int nonws_i;
  char[] dstr = cons_str.message.dup();
  DWriteln("Wrapping: \n---------\n", dstr);

  foreach ( _; dstr ) {
    // -- go through column width --
    foreach ( c; 0 .. cons_str.column_max ) {
      if ( i >= dstr.length ) {
        goto END;
      }
      if ( dstr[i] == '\n' ) {
        c = 0;
      }
      ++ i;
    }
    // -- force WS --
    for ( size_t j = i; j != 0; -- j ) {
      if ( dstr[j] == ' ' ) {
        dstr[j] = '\n';
        i = cast(int)j + 1;
        break;
      }
    }
  }
  END:
  DWriteln("\n-------\n");
  DWriteln("\n\nWrapped: \n--------\n", dstr);
  DWriteln("\n-------\n");
  cons_str.message = cast(string)dstr;
}

// a properly formatted console string
struct ConsoleString {
  int row_max, column_max;
  string message;
  this ( Message _message, int _column_max, int _row_max ) {
    message    = _message.R_Str();
    column_max = _column_max;
    row_max    = _row_max;
    Word_Wrap(this);
  }
};

private string[] main_window_str;

private void Output_String(ConsoleString cons_str) {
  string z;
  foreach ( c; cons_str.message ) {
    if ( c == '\n' ) {
      main_window_str ~= z;
      z = "";
      continue;
    }
    z ~= c;
  }
  if ( z != "" )
    main_window_str ~= z;
}

/**
  Outputs the message to the screen
**/
void Output_Message(Message msg) {
  // -- redraw window --
  // Draw_Window();
  // -- apply message --
  Output_String(ConsoleString(msg, 80, 130));

  DWriteln("MAIN WINDOW LENGTH: ", main_window_str.length);
  foreach ( i; 0 .. main_window_str.length ) {
    move(cast(int)i+3, 3);
    printw("%s", main_window_str[i].toStringz);
  }
}

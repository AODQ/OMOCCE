module OMOCCE.ConsoleUtility;
import std.stdio;
import std.string;
import std.regex;
import std.conv : to;
import Dialog = OMOCCE.Dialogue;

import core.sys.windows.windows;

enum colour {
  black = 0, dark_blue = 1, dark_green = 2, dark_aqua = 3, dark_red = 4,
  dark_purple = 5, dark_yellow = 6, dark_white = 7, gray = 8, blue = 9,
  green = 10, aqua = 11, red = 12, purple = 13, yellow = 14, white = 15
}

HANDLE Console_Handle() { return GetStdHandle(STD_OUTPUT_HANDLE); }
static HANDLE handle;
class KeyState {
  ubyte[256] state;
  bool shift, ctrl;
}
static KeyState keys;
KeyState* R_Keyboard_State() {
  foreach ( x; 0..250 ) {
    if ( GetAsyncKeyState(x) ) {
      if ( keys.state[x] != 2 ) keys.state[x] = 1;
    } else {
      keys.state[x] = 0;
    }
  }
  keys.shift = cast(bool)(keys.state[VK_LSHIFT  ] | keys.state[VK_RSHIFT  ]);
  keys.ctrl  = cast(bool)(keys.state[VK_LCONTROL] | keys.state[VK_RCONTROL]);
  return &keys;
} 

// returns 0 if invalid character
char R_Character(int y, bool shift) {
  char x = cast(char)y;
  if ( shift ) {
    if ( x >= 'A' && x <= 'Z' ) return x;
    char[char] shift_num = [
      '1': '!', '2': '@', '3': '#', '4': '$',
      '5': '%', '6': '^', '7': '&', '8': '*',
      '9': '(', '0': ')'
    ];
    if ( x >= '0' && x <= '9' )
      return shift_num[x];
  } else {
    if ( x >= 'A' && x <= 'Z' ) return cast(char)(x+32);
    if ( x >= '0' && x <= '9' ) return x;
  }
  if ( x == VK_SPACE ) return x;
  if ( x == VK_BACK  ) return x;
  return 0;
}



void Initialize_Window() {
  handle = Console_Handle();
  keys = new KeyState();
  SetConsoleScreenBufferSize(handle, COORD(128, 50));
  SetConsoleMode(handle, ENABLE_PROCESSED_INPUT);
  string window = "OMOCCE";
  SetConsoleTitleA(window.ptr);
  Clear_Screen();
  SetConsoleOutputCP(CP_UTF8);
}

void Clear_Screen() {
  DWORD count;
  auto coord = COORD(0, 0);
  CONSOLE_SCREEN_BUFFER_INFO info;
  GetConsoleScreenBufferInfo(handle, &info);
  auto cell_amt = info.dwSize.X * info.dwSize.Y;
  TCHAR space = cast(TCHAR)' ';
  FillConsoleOutputCharacter(handle, space, cell_amt, coord, &count);

  // return cursor
  SetConsoleCursorPosition(handle, coord);
}

void Clear_Screen(colour bg_col) {
  Clear_Screen();
  Reset_Cursor();
  string draw;
  foreach ( a; 0..128 ) draw ~= ' ';
  foreach ( a; 0..50) {
    Output(draw, 0, a, colour.aqua, bg_col);
  }
}

void Draw_Box(int x, int y, int w, int h, colour bg) {
  string draw;
  foreach ( a; 0..w ) draw ~= " ";
  foreach ( a; 0..h ) {
    Set_Cursor(x, y);
    Output(draw, x, y+a, bg, bg);
  }
}

void Draw_Box(int x, int y, int width, int height, colour border_fg,
                                colour border_bg, bool single_width) {
  string draw;
  string c_topleft = single_width ? "┌" : "╔",
         c_toprite = single_width ? "┐" : "╗",
         c_botleft = single_width ? "└" : "╚",
         c_botrite = single_width ? "┘" : "╝",
         c_horiz   = single_width ? "─" : "═",
         c_vertic  = single_width ? "│" : "║";

  // top
  draw = c_topleft;
  foreach ( a; 0..width ) draw ~= c_horiz;
  draw ~= c_toprite;
  Set_Cursor(x, y);
  Output(draw, border_fg, border_bg);
  // body
  draw = c_vertic;
  foreach ( a; 0..width ) draw ~= ' ';
  draw ~= c_vertic;
  foreach ( a; 0 .. height ) {
    Set_Cursor(x, y+1+a);
    Output(draw, x, y+1+a, border_fg, border_bg);
  }
  // bottom
  Set_Cursor(x, y+height);
  draw = c_botleft;
  foreach ( a; 0 .. width ) draw ~= c_horiz;
  draw ~= c_botrite;
  Output(draw, border_fg, border_bg);
}
// -- cursor
void Reset_Cursor() {
  SetConsoleCursorPosition(handle, COORD(0, 0));
}

void Set_Cursor(short x, short y) {
  CONSOLE_SCREEN_BUFFER_INFO info;
  GetConsoleScreenBufferInfo(handle, &info);
  if ( info.dwCursorPosition.X != x ||
       info.dwCursorPosition.Y != y )
    SetConsoleCursorPosition(handle, COORD(x, y));
}

void Set_Cursor(int x, int y) {
  Set_Cursor(cast(short)x, cast(short)y);
}

void Clear_Console_Attribute(HANDLE h) {
  SetConsoleTextAttribute( h, 0b0000111 );
}


void Output(string str, colour fg = colour.white,
                        colour bg = colour.black,
                        bool newln = true) {
  // look for inline text colour
  static auto rgx_colour = ctRegex!("(.*)%([\\d,cd]+)%(.*)");
  auto match = matchFirst(str, rgx_colour);
  if ( !match.empty ) {
    if ( match[1] != "" ) Output(match[1], fg, bg, false);
    string col_str = match[2];
    string[] cols = col_str.split(",");
    // foreground
    if ( cols[0] == "c" )
      fg = colour.white;
    else if ( cols[0] != "d" && cols[0] != "" )
      fg = cast(colour)(to!int(cols[0]));
    // background
    if ( cols.length > 1 ) { 
      if ( cols[1] == "c" )
        bg = colour.black;
      else if ( cols[1] != "" && cols[1] != "d" ) {
        bg = cast(colour)(to!int(cols[1]));
      }
    }
    str = match[3];
  }
  // do colourization/output
  ushort attrib = cast(ushort)(cast(ushort)(bg)<<4 | cast(ushort)(fg));
  SetConsoleTextAttribute(handle, attrib);
  auto buffer = str.ptr;
  WriteConsoleA(handle, buffer, str.length, null, null);
  if ( newln ) putchar('\n');
  Clear_Console_Attribute( handle );
}

void Output(wstring str, colour fg = colour.white,
                        colour bg = colour.black,
                        bool newln = true) {
  ushort attrib = cast(ushort)(cast(ushort)(bg)<<4 | cast(ushort)(fg));
  SetConsoleTextAttribute(handle, attrib);

  immutable(wchar)* w = str.ptr;
  WriteConsoleW(handle, w, str.length, null, null);
  if ( newln ) putchar('\n');

  Clear_Console_Attribute( handle );
}

void Draw_Tile(char til, int x, int y, colour bg = colour.black,
                                       colour fg = colour.white) {
  Set_Cursor(x, y);
  SetConsoleTextAttribute(handle, cast(ushort)((bg<<4)|fg));
  WriteConsoleA(handle, &til, 1, null, null);
}

void Output(string str, int x, int y, colour fg = colour.white,
                        colour bg = colour.black, bool preserve = true) {
  int px = x, py = y;
  Set_Cursor(x, y);
  Output(str, fg, bg, false);
  if ( preserve )
    Set_Cursor(px, py);
}

void Pause_Input() {
  SetConsoleCursorPosition(handle, COORD(0,  0));
  SetConsoleCursorPosition(handle, COORD(0,  50));
  while (  (GetAsyncKeyState(VK_RETURN)) ) {}
  while ( !(GetAsyncKeyState(VK_RETURN)) ) {}
}

string R_Input(bool show_input = false, int max_len = -1) {
  string inp = "";
  while ( (GetAsyncKeyState(VK_RETURN)) ) {}
  while ( !GetAsyncKeyState(VK_RETURN) ) {
    auto keys = R_Keyboard_State();
    int it = 0;
    foreach ( k; keys.state ) {
      auto n_char = R_Character(it, keys.shift);
      if ( k == 1 && n_char ) {
        keys.state[it] = 2;
          if ( show_input )
            Output(""~cast(char)(n_char), colour.white, colour.black, false);
          inp ~= it+32;
      }
      ++ it;
    }
  }
  return inp;
}

// specific outputs

string[] dialogue_buffer = ["", "", "", "", "", "", "", "", "", "", ""];

void Output_Dialogue(string str) {
  string orig = str.dup;
  str = "";
  int bef = 0;
  static immutable Cons_width = 98;
  for ( int it = Cons_width; it < orig.length; it += Cons_width ) {
    while ( orig[it] != ' ' ) -- it;
    str ~= orig[bef..it] ~ '\n';
    bef = it+1;
  }
  str ~= orig[bef..$];
  auto strs = str.splitLines();
  foreach ( s; strs ) {
    dialogue_buffer ~= s;
  }
  while ( dialogue_buffer.length > 11 )
    dialogue_buffer = dialogue_buffer[1..$];

  Output_Portrait(Dialog.Test_Portrait());
  uint it = 11;
  foreach ( s; dialogue_buffer ) {
    SetConsoleCursorPosition(handle, COORD(2, cast(short)(47-it)));
    Output(s);
    -- it;
  }
  writeln();
  SetConsoleCursorPosition(handle, COORD(2, 54));
  Sleep(500);
}

void Clear_Dialogue_Buffer() {
  dialogue_buffer = ["", "", "", "", "", "", "", "", "", "", ""];
}

void Output_Portrait(string str) {
  string[] strs = str.split('\n');
  int it = 0;
  foreach ( s; strs ) {
    SetConsoleCursorPosition(handle, COORD(100, cast(short)(it+37)));
    Output(s);
    ++ it;
  }
  SetConsoleCursorPosition(handle, COORD(2, 54));
}
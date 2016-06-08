module OMOCCE.ConsoleUtility;
import std.stdio;
import std.string;
import std.regex;
import std.conv : to;
import Dialog = OMOCCE.Dialogue;

import core.sys.windows.windows;

HANDLE Console_Handle() { return GetStdHandle(STD_OUTPUT_HANDLE); }
HANDLE handle;
void Initialize_Window() {
  handle = Console_Handle();
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

void Clear_Console_Attribute(HANDLE h) {
  SetConsoleTextAttribute( h, 0b0000111 );
}

enum console_colour {
  black = 0, dark_blue = 1, dark_green = 2, dark_aqua = 3, dark_red = 4,
  dark_purple = 5, dark_yellow = 6, dark_white = 7, gray = 8, blue = 9,
  green = 10, aqua = 11, red = 12, purple = 13, yellow = 14, white = 15
}

void Output(string str, console_colour fg = console_colour.white,
                        console_colour bg = console_colour.black,
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
      fg = console_colour.white;
    else if ( cols[0] != "d" && cols[0] != "" )
      fg = cast(console_colour)(to!int(cols[0]));
    // background
    if ( cols.length > 1 ) { 
      if ( cols[1] == "c" )
        bg = console_colour.black;
      else if ( cols[1] != "" && cols[1] != "d" ) {
        bg = cast(console_colour)(to!int(cols[1]));
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

void Output(wstring str, console_colour fg = console_colour.white,
                        console_colour bg = console_colour.black,
                        bool newln = true) {
  ushort attrib = cast(ushort)(cast(ushort)(bg)<<4 | cast(ushort)(fg));
  SetConsoleTextAttribute(handle, attrib);

  immutable(wchar)* w = str.ptr;
  WriteConsoleW(handle, w, str.length, null, null);
  if ( newln ) putchar('\n');

  Clear_Console_Attribute( handle );
}


void Pause_Input() {
  SetConsoleCursorPosition(handle, COORD(0,  0));
  SetConsoleCursorPosition(handle, COORD(0,  50));
  while (  (GetAsyncKeyState(VK_RETURN)) ) {}
  while ( !(GetAsyncKeyState(VK_RETURN)) ) {}
}

ubyte[256] keystate;

ubyte[256] R_Keyboard_State() {
  foreach ( x; 0..255 ) {
    if ( GetAsyncKeyState(x) ) {
      if ( keystate[x] != 2 ) keystate[x] = 1;
    } else {
      keystate[x] = 0;
    }
  }
  return keystate;
} 

bool Check_Valid(int y) {
  char x = cast(char)y;
  return (x >= 'A' && x <= 'Z') || (x >= '0' && x <= '9') || x == ' '
         || x == VK_BACK ;
}

string R_Input(bool show_input = false, int max_len = -1) {
  string inp = "";
  while ( (GetAsyncKeyState(VK_RETURN)) ) {}
  while ( !GetAsyncKeyState(VK_RETURN) ) {
    auto keys = R_Keyboard_State();
    int it = 0;
    foreach ( k; keys ) {
      if ( k == 1 && Check_Valid(it) ) {
        keystate[it] = 2;
          if ( show_input )
            Output(""~cast(char)(it+32), console_colour.white,
                   console_colour.black, false);
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
  Clear_Screen();
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

  Dialog.Print_Interface();
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
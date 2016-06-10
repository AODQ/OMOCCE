module OMOCCE.ArtGenerator;
import ConsoleUtil = OMOCCE.ConsoleUtility : colour;
import core.sys.windows.windows;
import std.conv : to;

static int x, y;
static colour fg, bg;

void Create_Art() {
  fg = colour.white;
  bg = colour.black;
  ConsoleUtil.Clear_Screen();
  while ( Check_Input() ) {
    
  }
}

bool Check_Input() {
  auto keys = ConsoleUtil.R_Keyboard_State();
  auto px = x, py = y;
  auto sh_dist = 5, ctrl_dist = 10;
  auto modifier = 1 + keys.shift*sh_dist + keys.ctrl*ctrl_dist;
  if ( keys.state[VK_LEFT] == 1 ) {
    if ( x > 0 ) x -= modifier;
    keys.state[VK_LEFT] = 2;
  }
  if ( keys.state[VK_RIGHT] == 1) {
    if ( x < 100 ) x += modifier;
    keys.state[VK_RIGHT] = 2;
  }
  if ( keys.state[VK_UP] == 1) {
    if ( y > 0 ) y -= modifier;
    keys.state[VK_UP] = 2;
  }
  if ( keys.state[VK_DOWN] == 1) {
    if ( y < 100 ) y += modifier;
    keys.state[VK_DOWN] = 2;
  }
  if ( x != px || y != py )
    ConsoleUtil.Set_Cursor(x, y);
  int character = 0;
  foreach ( k; keys.state ) {
    auto n_char = ConsoleUtil.R_Character(character, keys.shift);
    if ( k == 1 && n_char ) {
      keys.state[character] = 2;
      if ( keys.ctrl ) { // change colour
        colour[char] colours_map = [
          '1': colour.black      , '2': colour.dark_blue  ,
          '3': colour.dark_green , '4': colour.dark_aqua  ,
          '5': colour.dark_red   , '6': colour.dark_purple,
          '7': colour.dark_yellow, '8': colour.dark_white ,
          '9': colour.gray       , '0': colour.blue       ,
          'A': colour.green      , 'B': colour.aqua       ,
          'C': colour.red        , 'D': colour.purple     ,
          'E': colour.yellow     , 'F': colour.white      
        ];
        if ( keys.shift ) {
          bg = colours_map[cast(char)character];
        } else {
          fg = colours_map[cast(char)character];
        }
      } else
        ConsoleUtil.Output(""~n_char, x, y, fg, bg);
    }
    ++ character;
  }
  return true;
}
module OMOCCE.Dialogue;
// this should be the only file where line length may exceed 80 characters.
// this is because the game is intended to be played by 120 char width
// and therefore things such as interface and other such things may have
// to exceed 80 chars.
import ConsoleUtil = OMOCCE.ConsoleUtility : Output, Output_Dialogue, R_Input;
import std.stdio;
import std.utf;

void Intro() {
Output("\n\n");
Output("Welcome to %13,d%OMOCCE%c% v0.00 A perma-death RPG by %8%AODQ%c%!");
Output("Planned features include:");
Output("  ) Story and events that occur regardless of player's interaction");
Output("  ) An economic and political simulation");
Output("  ) Mobs that reproduce, travel, communicate, invade, etc");
Output("... and more!");
  ConsoleUtil.Pause_Input();
}

void Print_Interface() {
  ConsoleUtil.Clear_Screen();
Output("┌──────────────────────────────────────────────────────────────────────────────────────────────────┬───────────────────┐"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("╞══════════════════════════════════════════════════════════════════════════════════════════════════╪═══════════════════╡"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("│                                                                                                  │                   │"w);
Output("└──────────────────────────────────────────────────────────────────────────────────────────────────┴───────────────────┘"w);

}

string Character_Creation_Get_Name() {
  ConsoleUtil.Clear_Dialogue_Buffer();
  string bad_name = R_Input(true);
  if ( bad_name == "ciggbit" ) {
Output_Dialogue("We truly are one in the same! Your name is the same as mine!");
    return bad_name;
  }
  if ( bad_name == "" ) {
Output_Dialogue("Don't talk much then? Well, I guess I can come up with a name for you. How does %7%enthack%c% sound to you? "~
                "No need to answer that, I know it's perfect.");
    return "enthack";
  }
Output_Dialogue(
"Why that's a pretty bad name, %5%"~bad_name~"%c% is not suitable for you!"
);
Output_Dialogue(
"I'll tell you what, my name is %10%ciggbit%c%, now "~
"tell me yours! OK, seriously though, since you're the only gateway I have to %9%Omonala%c% at the time, I can "~
"not allow you to draw attention to yourself with such foolish names. Choose a better one." 
);
  string name = R_Input(true);
  if ( name == "ciggbit") {
Output_Dialogue("Now you are trying to make fun of my name? This is funny coming from the %5%"~bad_name~"%c%, but you "~
              "should know I'm the master of choosing names. In fact, I've already come up with a better name. From "~
              "now on you shall refer to me as AODQ! You can keep ciggbit, I've no need for it now.");
    return name;
  }
  if ( name == bad_name ) {
    Output_Dialogue("No no, trust me, you do not want that name. This is a serious matter, you might seriously piss someone off "~
                    "with such a bad taste in naming oneself!");
    name = R_Input(true);
  }
  if ( bad_name == "" ) {
Output_Dialogue("Don't talk much then? Well, I guess I can come up with a name for you. How does %7%enthack%c% sound to you? "~
                "No need to answer that, I know it's perfect.");
    return "enthack";
  }
  
  if ( name == "ciggbit") {
Output_Dialogue("Now you are trying to make fun of my name? This is funny coming from the %5%"~bad_name~"%c%, but you "~
              "should know I'm the master of choosing names. In fact, I've already come up with a better name. From "~
              "now on you shall refer to me as AODQ! You can keep ciggbit, I've no need for it now.");
    return name;
  }
  if ( bad_name == "" ) {
Output_Dialogue("Don't talk much then? Well, I guess I can come up with a name for you. How does %7%enthack%c% sound to you? "~
                "No need to answer that, I know it's perfect.");
    return "enthack";
  }
  if ( name == bad_name ) {
Output_Dialogue("Fine, have it your way, just remember that I warned you.");
    return name;
  }
Output_Dialogue("%5%" ~ name ~ "%c%" ~ " is really not much better, it is no %10%ciggbit%c%, but it will do I suppose.");
  return name;
}

void Character_Creation() {
Print_Interface();
ConsoleUtil.Output_Portrait(Test_Portrait());

Output_Dialogue(
"Hello stranger, welcome to the fair lands of %9%Omonala%c%! " ~
"I am but a figment of your imagination, for the time being at least. " ~
"Now, I suspect that you have been, and I will tell you of why I suspect so later, "~
"%6%zapped%c% here! By whom and for what reason is unclear, and it seems you have forgotten as well "~
"who you were beforehand, along with even where you originate from. But I'm sure you are aware as "~
"much as I that this will be cleared "~
"in the future. Just remember; not all is lost, for you have me to guide you! " ~
"Now to put it straight-forward, I know know more than what you know, and I know even what is left in the deep crevices "~
"of your subconscious. "~
"Even so, I do not know your name. But say, I'll tell you what, since you seem to still be awakening, I think this is the perfect "~
"time to give me your name!");

  string name = Character_Creation_Get_Name();
  Output_Dialogue(
"Well anyways " ~ name ~ ", it seems you are waking up. Rise and shine, though I have a feeling that you're going to regret "~
"a lot of things you are about to do before you even have a chance to know of their implications. And likewise, many things "~
"will happen to you that should not have had you only a little more wisdom on this new world. "~
" I'll keep an eye on you.");
}

string Test_Portrait() {
  string str = "";
  str ~= "      %%%        \n";
  str ~= "    ########     \n";
  str ~= "  ### 2##  ###   \n";
  str ~= "   1 22  %2%0%c%  1    \n";
  str ~= "   22       1    \n";
  str ~= "   1  000   1  11\n";
  str ~= "    11    11  11 \n";
  str ~= "    %4%333333333%c% 1  \n";
  str ~= "  22%4%333333333%c%11  \n";
  str ~= "  22%4%333333333%c%1   \n";
  str ~= " 1  %4%333333333%c%    \n";
  return str;
}
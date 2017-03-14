// Written in the D programming language.
import global;
import area;

void Load_Data ( ) {
  locations ~= new Area("Inside Tanker", "this tanker has blh blah balh blah bl");
}

void Initialize_Terminal ( ) {
	terminal.open("omocce");

	// Set some settings
	terminal.set("input.cursor-blink-rate=2147483647");
	terminal.set("input.cursor-symbol=0x2588");
	terminal.set(`font: DejaVuSansMono.ttf, use-box-drawing=false,
                use-block-elements=true, size=12x24`);
  terminal.set(`output.tab-width=2;`);
}

void main() {
  Initialize_Terminal();
  Load_Data();

  import engine, window;

  Window[string] windows = [
    "title" : Window("title", 0, 0, 80, 2, 0, false, false, Alignment.middle),
    "description" : Window("description", 0, 1, 80, 22, 1, false, true),
    "input" : Window("input", 0, 23, 80, 5, 2, false, false)
  ];

  Output ( windows["title"], new Om_String(
    ".: Valley of Ter :."
  ));
  Output ( windows["description"], new Om_String(
    `It's important to note that these (those three worrisome things) are not trends and that they've been in the making for far longer than twelve months. They are symptoms that are inextricably linked to the core nature of the Web as it exists within the greater socio-technological system we live under today that we call Surveillance Capitalism. Tim says we've "lost control of our personal data." This is not entirely accurate. We didn't lose control; it was stolen from us by Silicon Valley. It is stolen from you every day by people farmers; the Googles and the Facebooks of the world. It is stolen from you by an industry of data brokers, the publishing behavioural advertising industry ("adtech"), and a long tail of Silicon Valley startups hungry for an exit to one of the more established players or looking to compete with them to own a share of you. The elephants in the room -- Google and Facebook -- stand silently in the wings, unmentioned except as allies later on in the letter where they're portrayed trying to "combat the problem" of misinformation. Is it perhaps foolish to expect anything more when Google is one of the biggest contributors to recent web standards at the W3C and when Google and Facebook both help fund the Web Foundation? Let me state it plainly: Google and Facebook are not allies in our fight for an equitable future -- they are the enemy. These platform monopolies are factory farms for human beings; farming us for every gram of insight they can extract. If, as Tim states, the core challenge for the Web today is combating people farming, and if we know who the people farmers are, shouldn't we be strongly regulating them to curb their abuses? There's quite a lot of stuff put here but rest assured this is not the end of whatever this sentence is ill just keep typign until i hit the limit of the window so i can test various window stuff hopefully these dimensions work but i dont know maybe it will`
  ));

  Output ( windows["input"], new Om_String("--------------------------------------------------------------------------------\n>> Check Inventory"
  ));

  terminal.refresh();

  while ( terminal.read() != 0xE0 ) {}
	terminal.close();
}

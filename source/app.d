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

  WindowInfo info = {
    start_x : 0, start_y : 1,
    end_x   : 80, end_y : 23,
    layer   : 1, text_wrap : true,
    alignment : Alignment.left
  };
  Window[string] windows = [
    // "title" : new Window("title", 0, 0, 80, 2, 0, false, false, Alignment.middle),
    "description" : new OutputLogWindow(info)
    // "input" : new Window("input", 0, 23, 80, 5, 2, false, false)
  ];

  // Output ( windows["title"], new OMString(
  //   ".: Valley of Ter :."
  // ));
  Output ( windows["description"], CreateOMString(
    `Your conscious awakens
 You are unable to see anything, you wonder if it is because your environment is pitch-black, or that you are blind. You aren't left to wonder about this for long because of the rancid stench of feces and a pungent smell of rotting meat. . . .
The left side of you is engrossed by a blinding light, you cover your eyes with your hands and look in the opposite direction.
  You uncover your hand from your face for a moment and see the faces of many decaying bodies, some of them are hanging limp, lifeless. The remaining are squinting their eyes but the shackles to their seats prevent them from moving their head or hands.
..
  Your eyes have adjusted to the light. You wonder if now is the right time to LOOK.
(LOOK) Your eyes fill with a bright light and you feel as if you are now in a location that is different from before. You close your eyes.
....
(LOOK) You see a scorched battlefield in the middle of a vast field. Most of the sparse trees among some patches of blue grass is on fire, painting the bright blue sky with a hazy black smoke. Most of what was certainly once a beautiful plain is now a muddy landscape.
  Several people dressed in thick metal armour are combatting each other a distance to the north. You can hear their clinging of their weapons along with their battlecries.
  You can not see anything else.
  You feel uneasy
  .
  A man in thick armour is running towards you from the north. You reckon you only have a few moments to decide on whether you want to wait for him or run. The thought passes your mind to try to get a better look at him.
  (LOOK MAN)
  You see a man in thick metallic armour adorned with several blue stripes. The armour covers his entire body, from his pointy boots to the thick blue scarf on his neck. He is not wearing a helmet. He has a thick facial structure, he would be rather handsome if it were not for the several scars covering his face.
  He is waving his hands towards you. You can not make out any more details.
  ...
  You can hear the man in thick armour yelling, "Xen! Are you OK?"
    `
  ));

  // Output ( windows["input"], new OMString("--------------------------------------------------------------------------------\n>> Check Inventory"
  // ));

  terminal.refresh();

  while ( terminal.read() != 0xE0 ) {}
	terminal.close();
}

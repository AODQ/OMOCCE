module Location.Base;
import Global;

class Location {
  Location[Dir.max] surrounding;

public:
  this() {
  }

  import ConsoleUtil.Message;
  Message R_Message() {
    return new Message("A small oasis town in the middle of this wasteland "
        "continent. Although no star does shine on Asgaratha, you have no "
        " visual trouble here as there are several buildings made of a dim blue "
        " substance, giving off a substantial amount of light.\n\n"
        " There is a sloth-creature with several horns playing in the sand"
        " You recognize Jez the Great Ox Merchant\n"
        " You believe to recognize Peal hiding in the shadows\n"
        " A townsguarde approaches you and asks to see your identity\n");
  }
};


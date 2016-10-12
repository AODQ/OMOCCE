module ConsoleUtil.Message;

class Message {
  string msg;
public:
  this ( string n ) {
    msg = n;
  }
  string R_Str() { return msg; }
}

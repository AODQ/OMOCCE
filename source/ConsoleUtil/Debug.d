module ConsoleUtil.Debug;
import std.stdio; 
bool file_exists = 0;
static File fil;
void DWriteln(T...)(T args) {
  if ( !file_exists ) {
    fil = File("DEBUG.txt", "w");
    file_exists = true;
  }
  fil.write(args, '\n');
}

void DWrite(T...)(T args) {
  if ( !file_exists ) {
    file_exists = true;
    fil = File("DEBUG.txt", "w");
  }
  fil.write(args);
}

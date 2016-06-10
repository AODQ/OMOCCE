module OMOCCE.MapLoader;
import OMOCCE.LocalWorld;
import std.file;
import std.stdio;


LocalWorld Load_Map(string location) {
  auto file = File(location, "r");
  while ( !file.eof() ) {
    auto str = file.readln();
    foreach ( c; str ) {
      
    }
  }
}
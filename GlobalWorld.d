module OMOCCE.GlobalWorld;
import OMOCCE.LocalWorld;
import OMOCCE.Entities.Entity;

class GlobalWorld {
private:
  this() {}
  static GlobalWorld inst = null;
  Entity[uint] entity_list;
  LocalWorld[uint] local_worlds;  
public:
  static GlobalWorld R_Inst() {
    return inst is null ? inst = new GlobalWorld : inst;
  }
  static void Add_Local_World(LocalWorld world) {
    auto inst = R_Inst();
    inst.local_worlds[world.R_ID()] = world;
  }
  static LocalWorld* R_Local_World(uint id) {
    auto isnt = R_Inst();
    if ( (id in inst.local_worlds) !is null )
      return &inst.local_worlds[id];
    return null;
  }

  void Add_Entity() {
    
  }

  void Rem_Entity() {}
  void R_Entity(uint id) {

  }
}

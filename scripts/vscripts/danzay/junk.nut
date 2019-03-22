
function TestButton() {
    oldOrigin <- self.GetOrigin();

    entity <- null;
    entity = Entities.FindByName(entity, "test_tp_dest");
    TeleportPlayerTo(entity);

    entity = null;
    entity = Entities.FindByName(entity, "yellow");
    EntFireByHandle(entity, "IncrementTextureIndex", "", 0.0, self, self);

    self.SetOrigin(oldOrigin);
}
let ECS = import("ecs");

let Map = import("./Map");
let Goblin = import("./Goblin");
let Hero = import("./Hero");
let Kitten = import("./Kitten");

let ParentMap = Map.create({
    Hero = Hero.create ,
    Goblin = Goblin.create,
    Kitten = Kitten.create 
});

let ForestMap = {
    create = |world| => {
        let inst = { world = world } @ ForestMap;
        inst->load("maps/", "map.tmx");

        let fm = ECS.Entity.create();
        fm->addComponent(ECS.Components.Tilemap.create(inst.tilemap));
        fm->setTag("Tilemap");

        world->addEntity(fm);

        return fm;
    }
} @ ParentMap;

return ForestMap;
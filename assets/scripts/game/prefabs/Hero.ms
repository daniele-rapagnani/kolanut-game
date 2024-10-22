let ECS = import("ecs");
let GameComps = import("../components");
let GameAssets = import("../Assets");

let Hero = {
    create = |world| => {
        let hero = ECS.Entity.create();

        let tr = ECS.Components.Transform.create();
        let fa = ECS.Components.FrameAnimation.create();
        let rb = ECS.Components.Rigidbody.create();
        let sr = ECS.Components.SpriteRenderer.create(GameAssets.Sprites.Hero);

        hero->addComponent(tr);
        hero->addComponent(sr);
        hero->addComponent(rb);
        hero->addComponent(fa);
        hero->addComponent(ECS.Components.TileCollider.create());
        hero->addComponent(GameComps.PlatformController.create());
        hero->addComponent(ECS.Components.Collider.create());
        hero->addComponent(GameComps.Player.create());

        fa->addAnimation({
            name = "die",
            frameSize = Rect.create(Vector2.create(0, 0), Vector2.create(16, 16)),
            totalFrames = 8,
            duration = 0.15
        });

        fa->addAnimation({
            name = "idle",
            frameSize = Rect.create(Vector2.create(0, 16 * 4), Vector2.create(16, 16)),
            totalFrames = 4,
            duration = 0.15
        });

        fa->addAnimation({
            name = "hit",
            frameSize = Rect.create(Vector2.create(0, 16 * 7), Vector2.create(16, 16)),
            totalFrames = 3,
            duration = 0.15
        });

        fa->playAnimation("idle");

        tr.origin.x = 8;
        tr.origin.y = 10;

        hero->setTag("Player");
        
        hero.Player.onDeath = => {
            let gameOver = world->getTaggedEntities("Game Over Label")[0];
            gameOver.Label.enabled = true;

            world->scheduleFunction(=> {
                world->clearEntities();
                world.scene->reload();
            }, 2.0);
        };

        hero.PlatformController.animations.run = "idle";
        hero.PlatformController.animations.dash = "idle";
        hero.PlatformController.sounds.jump = GameAssets.Sounds.Jump;
        hero.PlatformController.sounds.land = GameAssets.Sounds.Land;
        hero.Player.sounds.hit = GameAssets.Sounds.Hit;
        hero.Player.sounds.death = GameAssets.Sounds.Death;

        return hero;
    }
};

return Hero;
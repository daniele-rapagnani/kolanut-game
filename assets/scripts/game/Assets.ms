let Assets = {
    Fonts = {
        Title = null,
        Small = null
    },

    Sprites = {
        Hero = null,
        Goblin = null,
        Kitten = null
    },

    UI = {
        Heart = null,
        NoHeart = null
    },

    Sounds = {
        Jump = null,
        Land = null,
        Hit = null,
        Death = null,
        Attack = null,
        Collect = null,
        Music = null
    },

    load = => {
        Assets.Fonts.Pixel = Kolanut.loadFont("fonts/Pokemon Classic.ttf", 48);

        Assets.Sounds.Jump = Kolanut.loadSound("sounds/jump.wav");
        Assets.Sounds.Land = Kolanut.loadSound("sounds/land.wav");
        Assets.Sounds.Hit = Kolanut.loadSound("sounds/hit.wav");
        Assets.Sounds.Death = Kolanut.loadSound("sounds/death.wav");
        Assets.Sounds.Attack = Kolanut.loadSound("sounds/attack.wav");
        Assets.Sounds.Collected = Kolanut.loadSound("sounds/collect.wav");
        Assets.Sounds.Music = Kolanut.loadSound("sounds/music.wav");

        Assets.Sprites.Hero = Kolanut.loadSprite("graphics/herochar_spritesheet.png");
        Assets.Sprites.Goblin = Kolanut.loadSprite("graphics/goblin_spritesheet.png");
        Assets.Sprites.Kitten = Kolanut.loadSprite("graphics/kitten.png");
        
        Assets.UI.Heart = Kolanut.loadSprite("graphics/hearts_hud.png");
        Assets.UI.NoHeart = Kolanut.loadSprite("graphics/no_hearts_hud.png");
    }
};

return Assets;
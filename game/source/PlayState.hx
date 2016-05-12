package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class PlayState extends FlxState
{

    var map:FlxTilemap;
    var player:FlxSprite;
    var bg:FlxSprite;
    var mapData:Array<Int> = [
        0 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        29,29,29,29, 0,29,29, 0,29, 0,29, 0, 0, 0, 0, 0,
        0 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0 , 0, 0, 0,29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0 , 0, 0,29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0 , 0, 0, 0, 0, 0, 0,29, 0, 0, 0,29, 0,29,29,29,
        0 , 0, 0, 0, 0, 0, 0, 0, 0, 0,29, 0, 0, 0, 0, 0,
        0 , 0, 0, 0, 0, 0, 0, 0, 0,29, 0, 0, 0, 0, 0, 0,
        0 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0 , 0, 0, 0, 0, 0,29,29,29,29, 0, 0, 0, 0, 0, 0,
        0 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0 ,29,29,29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0 , 0, 0,44, 0,29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        29, 0, 0,44, 0,44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0 , 0, 0,44, 0,44,29,29, 0,29,29,29, 0,29, 0, 0,
        0 ,29, 0,44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0 , 0, 0,44,29,29,29,29,29, 0, 0, 0, 0, 0, 0, 0,
        0 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,29,29,
        29,29,29, 0, 0, 0, 0, 0, 0, 0, 0, 0,29, 0, 0, 0,
        0 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    ];

	override public function create():Void
	{
        bg  = new FlxSprite(0,0);
        bg.loadGraphic(AssetPaths.bg__png);
        add(bg);

        map = new FlxTilemap();
        map.loadMapFromArray(mapData, 16,21, AssetPaths.sheet__png, 48, 48);
        add(map);

        player = new FlxSprite(64, 0);
        player.makeGraphic(48, 48, FlxColor.RED);
        player.acceleration.y = 800;
        add(player);

        super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

        FlxG.collide(map, player);
        movePlayer();
	}

    private function movePlayer():Void
    {
        //#TODO:0 need to get the jump
        player.velocity.x = 0;
        if (FlxG.keys.pressed.LEFT)
            player.velocity.x -= 200;

        if (FlxG.keys.pressed.RIGHT)
            player.velocity.x += 200;

        if (FlxG.keys.justPressed.C && player.isTouching(FlxObject.FLOOR))
            player.velocity.y = -400;
    }
}

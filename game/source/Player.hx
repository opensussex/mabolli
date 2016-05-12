import flixel.FlxSprite;
import flixel.FlxG;

class Player extends FlxSprite
{

    private static inline var ACCELERATION:Int = 320;
    private static inline var DRAG:Int = 320;
    private static inline var GRAVITY:Int = 600;
    private static inline var JUMP_FORCE:Int = -280;
    private static inline var WALK_SPEED:Int = 120;
    private static inline var RUN_SPEED:Int = 140;
    private static inline var FALLING_SPEED:Int = 300;

    public var direction:Int = 0;

    public function new(x:Float, y:Float)
    {
        super(x, y);
        loadGraphic(AssetPaths.characterWalk__png, true, 140, 173);
        animation.add("idle", [0]);
        animation.add("walk", [
                            1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38], 32);
        setSize(140, 173);
        scale.x=0.5;
        scale.y=0.5;
        drag.x = DRAG;
        acceleration.y = GRAVITY;
        maxVelocity.set(WALK_SPEED, FALLING_SPEED);
        flipX = true;
    }

    override public function update(elapsed:Float):Void{
        move();
        animate();
        super.update(elapsed);
    }

    private function move()
    {
        acceleration.x = 0;

        if(FlxG.keys.pressed.LEFT){
            flipX = false;
            direction = -1;
            acceleration.x -= ACCELERATION;
        }else if(FlxG.keys.pressed.RIGHT) {
            flipX = true;
            direction = 1;
            acceleration.x += ACCELERATION;
        }
    }

    private function animate()
    {
        animation.play("walk");
    }
}

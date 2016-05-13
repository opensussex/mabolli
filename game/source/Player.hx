import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.FlxMath;

class Player extends FlxSprite
{

    private static inline var ACCELERATION:Int = 320;
    private static inline var DRAG:Int = 320;
    private static inline var GRAVITY:Int = 600;
    private static inline var JUMP_FORCE:Int = -320;
    private static inline var WALK_SPEED:Int = 120;
    private static inline var RUN_SPEED:Int = 180;
    private static inline var FALLING_SPEED:Int = 400;

    public var direction:Int = 0;
    public var animation_state:String = ''; // are we currently walking / running etc?

    public function new(x:Float, y:Float)
    {
        super(x, y);
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

        if (velocity.y == 0){
            if (FlxG.keys.justPressed.C && isTouching(FlxObject.FLOOR))
                velocity.y = JUMP_FORCE;

            if (FlxG.keys.pressed.X)
                maxVelocity.x = RUN_SPEED;
            else
                maxVelocity.x = WALK_SPEED;
        }

        if ((velocity.y < 0) && (FlxG.keys.justReleased.C))
            velocity.y = velocity.y * 0.8;
    }


    private function animate()
    {
        if ((velocity.y <= 0) && (!isTouching(FlxObject.FLOOR)))
            animationType('jump');
        else if (velocity.y > 0)
            animationType('fall');
        else if (velocity.x == 0)
            animationType('idle');
        else
        {
            if (FlxMath.signOf(velocity.x) != FlxMath.signOf(direction))
                animation.play("skid");
            else
                animationType('walk');
        }
    }

    private function animationType(animation_type:String)
    {

        trace('as' + animation_state + ' | ' + animation_type);
        if(animation_state != animation_type) {
            switch(animation_type){
                case 'idle':
                    loadGraphic(AssetPaths.characterIdle__png, true, 57, 79);
                    setSize(65, 83);
                    animation.add("idle", [
                                            1,2,3,4,5,6,7,8,9,10,
                                            11,12,13,14,15,16,17,18,19,20,
                                            21,22,23,24,25,26,27,28,29,30,
                                            31,32,33,34
                                            ], 32);
                    animation.play("idle");
                case 'jump':
                    loadGraphic(AssetPaths.characterJump__png, true, 75, 91);
                    setSize(75, 90);
                    animation.add("jump", [
                                            1,2,3,4,5,6,7,8,9,10,
                                            11,12,13,14,15
                                            ], 32);
                    animation.play("jump");
                case 'fall':
                    loadGraphic(AssetPaths.characterFall__png, true, 91, 83);
                    setSize(65, 83);
                    animation.add("fall", [
                                            1,2,3,4,5,6,7,8,9,10,
                                            11,12,13,14,15,16,17,18,19,20,
                                            21,22,23,24,25,26,27,28,29,30,
                                            31,32,33,34
                                            ], 32);
                    animation.play("walk");

                case 'walk':
                    loadGraphic(AssetPaths.characterWalk__png, true, 70, 87);
                    setSize(65, 83);
                    animation.add("walk", [
                                            1,2,3,4,5,6,7,8,9,10,
                                            11,12,13,14,15,16,17,18,19,20,
                                            21,22,23,24,25,26,27,28,29,30,
                                            31,32,33,34,35,36,37,38
                                            ], 32);
                    animation.play("walk");

            }
            animation_state = animation_type;
        }

    }
}

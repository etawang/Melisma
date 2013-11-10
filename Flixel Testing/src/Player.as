package
{
	import org.flixel.*;

	public class Player extends FlxSprite
	{
		//Player Image.
		[Embed(source = "../assets/sprites/runner_strip1.png")] private var ImgPlayer:Class

		protected var _jumpPower:int;
		protected var _restart:Number;
		
		//This is the player object class.
		public function Player(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(ImgPlayer,true,true,34,32);
			_restart = 0;
			
			//bounding box tweaks
			width = 32;
			height = 32;
			offset.x = 0;
			offset.y = 0;
			
			//basic player physics
			var runSpeed:uint = 400; //may be edited as seen fit
			drag.x = runSpeed*16;
			acceleration.y = 2000;
			_jumpPower = 800;
			maxVelocity.x = runSpeed;
			maxVelocity.y = 1000;
			
			allowCollisions = ANY;
			
			//animations
			addAnimation("idle", [2]);
			addAnimation("run", [3, 4, 0, 1, 2], 12);
		}

		override public function destroy():void
		{
			super.destroy();
		}

		override public function update():void
		{
			//MOVEMENT
			acceleration.x = 0;
			if(FlxG.keys.LEFT)
			{
				facing = LEFT;
				acceleration.x -= drag.x;
			}
			else if(FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				acceleration.x += drag.x;
			}
			if (FlxG.keys.justPressed("SPACE") && this.isTouching(FLOOR)/*!velocity.y*/)
			{
				velocity.y = -_jumpPower;
			}
			
			if (velocity.x)
			{
				play("run");
			}
			else 
			{
				play("idle");
			}
			if (this.x < 16) {
				this.x = 16;
			}
		}
	}
}
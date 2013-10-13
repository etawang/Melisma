package
{
	import org.flixel.*;

	public class Player extends FlxSprite
	{
		//Player Image.
		[Embed(source = "../assets/sprites/PlayerTest.png")] private var ImgPlayer:Class

		protected var _jumpPower:int;
		protected var _restart:Number;
		
		//This is the player object class.
		public function Player(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(ImgPlayer,false,true);
			_restart = 0;
			
			//bounding box tweaks
			width = 8;
			height = 8;
			offset.x = 0;
			offset.y = 0;
			
			//basic player physics
			var runSpeed:uint = 400; //may be edited as seen fit
			drag.x = runSpeed*16;
			acceleration.y = 2000;
			_jumpPower = 800;
			maxVelocity.x = runSpeed;
			maxVelocity.y = 1000;
			
			//animations
			addAnimation("idle", [0]);
			addAnimation("run", [1, 2, 3, 0], 12);
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
			if(FlxG.keys.justPressed("SPACE") && !velocity.y)
			{
				velocity.y = -_jumpPower;
			}
		}
		
		override public function kill():void
		{
			if(!alive)
				return;
			solid = false;
			super.kill();
			flicker(0);
			exists = true;
			visible = false;
			/* can be used for tracking */
			velocity.make();
			acceleration.make();
			/* animate screen */
			FlxG.camera.shake(0.005,0.35);
			FlxG.camera.flash(0xffd8eba2,0.35);
		}
	}
}
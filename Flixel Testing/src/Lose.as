package
{
	import org.flixel.*;

	public class Lose extends FlxSprite
	{
		//Player Image.
		[Embed(source = "../assets/sprites/lose1.png")] private var ImgLose:Class

		//This is the player object class.
		public function Lose(X:int,Y:int)
		{
			super(X, Y);
			loadGraphic(ImgLose, true, false, 66, 64);
			
			//bounding box tweaks
			width = 64;
			height = 64;
			offset.x = 0;
			offset.y = 0;
			
			scale.x = 2;
			scale.y = 2;
			
			//animations
			addAnimation("default", [0,1,2], 12);
		}
		
		public function isJumping():int 
		{
			return (int)(velocity.y < 0);
		}


		override public function destroy():void
		{
			super.destroy();
		}
		
		override public function update():void
		{
			
		}
	}
}
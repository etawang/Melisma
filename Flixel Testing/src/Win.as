package
{
	import org.flixel.*;

	public class Win extends FlxSprite
	{
		//Player Image.
		[Embed(source = "../assets/sprites/win1.png")] private var ImgWin:Class

		//This is the player object class.
		public function Win(X:int,Y:int)
		{
			super(X, Y);
			loadGraphic(ImgWin, true, false, 66, 64);
			
			//bounding box tweaks
			width = 64;
			height = 64;
			offset.x = 0;
			offset.y = 0;
			
			scale.x = 2;
			scale.y = 2;
			
			//animations
			addAnimation("default", [0, 1], 12);
			play("default");
		}

		override public function destroy():void
		{
			super.destroy();
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}
}
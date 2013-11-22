package
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Fire extends FlxSprite
	{
		[Embed(source = "../assets/sprites/bg/left.png")] private var ImgFire:Class
		
		public function Fire() {
			super(-80, 0);
			loadGraphic(ImgFire, true, false, 80, 640);
			//this.velocity.x = 5;	
			//this.myDirection = 0;
			
			addAnimation("burn", [0, 1, 2], 12);
			play("burn");
			allowCollisions = ANY;
		}
		
		override public function update():void
		{
			super.update();
			//if (this.x <= -50) {
				//something to move fire forward
			//	kill();
			//}
		}
	}
	
}
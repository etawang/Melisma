package
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Arrow extends FlxSprite
	{
		[Embed(source = "../assets/sprites/arrowstrip1.png")] private var ImgArrow:Class
		
		//0 is left, 1 is up, 2 is right, 3 is down
		private var myDirection:int;
		
		public function Arrow() {
			super(FlxG.width, 600);
			loadGraphic(ImgArrow, true, false, 41.5, 40);
			this.velocity.x = -100;	
			this.myDirection = 0;
			
			addAnimation("left", [0]);
			addAnimation("up", [1]);
			addAnimation("right", [2]);
			addAnimation("down", [3]);
			addAnimation("hit", [/*stuff*/], 12, false);
			addAnimation("miss", [/*stuff*/], 12, false);
			allowCollisions = ANY;
		}
		
		public function getDirection() : int {
			return myDirection;
		}
		
		public function arrowHit() {
			play("hit");
		}
		
		public function arrowMiss() {
			play("miss");
		}
		
		override public function update():void
		{
			super.update();
			if (this.x <= -50) {
				//something to move fire forward
				kill();
			}
		}
		
		public function newArrow(x:uint, y:uint, r:Number):void
		{
			reset(x, y);
			myDirection = (int)(4 * r);
			if (myDirection == 0) {
				play("left");
			}
			else if (myDirection == 1) {
				play("up");
			}
			else if (myDirection == 2) {
				play("right");
			}
			else if (myDirection == 3) {
				play("down");
			}
		}

	}
	
	
}
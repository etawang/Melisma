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
		
		//data for arrow directions
		public static var ARROW_UP:int = 0;
		public static var ARROW_DOWN:int = 1;
		public static var ARROW_LEFT:int = 2;
		public static var ARROW_RIGHT:int = 3;
		
		//current direction of this arrow
		private var myDirection:int;
		private var processed:Boolean;
		
		public function Arrow() {
			super(FlxG.width, 600);
			loadGraphic(ImgArrow, true, false, 41.5, 40);
			this.velocity.x = -100;	
			this.myDirection = 0;
			
			myDirection = 0;
			processed = false;
			
			addAnimation("up", [0]);
			addAnimation("down", [1]);
			addAnimation("left", [2]);
			addAnimation("right", [3]);
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
			if (this.x <= -200) {
				//something to move fire forward
				kill();
			}
		}
		
		public function newArrow(x:uint, y:uint, r:Number):void
		{
			reset(x, y);
			myDirection = (int)(4 * r);
			if (myDirection == ARROW_LEFT) {
				play("left");
			}
			else if (myDirection == ARROW_UP) {
				play("up");
			}
			else if (myDirection == ARROW_RIGHT) {
				play("right");
			}
			else if (myDirection == ARROW_DOWN) {
				play("down");
			}
		}
		
		override public function kill():void
		{
			//need to create a shadow here
			super.kill();
		}

		public function setProcessed(b:Boolean):void
		{
			processed = b;
		}

		public function isProcessed():Boolean
		{
			return processed;
		}
	}
	
	
}
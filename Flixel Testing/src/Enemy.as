package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	/**
	 * Enemy Class.
	 * @author Celestics
	 */
	public class Enemy extends FlxSprite
	{
		//UTILITY CLASS
		private var util:Utility = PlayState.util;
		
		/** ALL STATIC VARIABLES **/
		
		//Enemy Image.
		[Embed(source = "../assets/sprites/EnemyTest.png")] private var ImgEnemy:Class
		
		//Movement data.
		private static var X_SPEED:int = 5;
		
		/*
		 * Constructor. Takes in (x, y) position coordinates,
		 * v velocity, a acceleration, aa angular acceleration.
		 */
		public function Enemy(/*x:uint, y:uint*/) 
		{
			super(FlxG.width, 610, ImgEnemy);
			this.velocity.x = -200;
			mass = 20;
			allowCollisions = ANY;
		}
		
		override public function update():void
		{
			this.velocity.x = -200;
			//checkHealth();
			super.update();
		}
		
		public function checkHealth():void
		{
			if (this.x <= -50)
			{
				kill();
			}
		}
	}

}
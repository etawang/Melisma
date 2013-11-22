package  
{
	import org.flixel.FlxObject;
	/**
	 * GameEvent Class.
	 * 
	 * @author Celestics
	 */
	public class GameEvent extends FlxObject
	{
		//Type String.
		public var type:int; //one of 4 types
		
		//Number Timestamp.
		public var timestamp:Number; //time of occurrence
		
		public function GameEvent(t:int, ti:Number) 
		{
			type = t;
			timestamp = ti;
		}
	}

}
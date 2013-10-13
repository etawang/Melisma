package
{
	import org.flixel.*;
	import org.flixel.system.FlxList;
	/**
	 * ...
	 * @author Celestics
	 */
	public class LoadState extends FlxState
	{
		//List of Events. This will go to the PlayState.
		public static var musicData:FlxList = null;
		
		//Raw String Input.
		public var rawData:String = "";
		
		public function LoadState()
		{
			
		}
		
		override public function create():void
		{
			//Initialize after load.
			var text:FlxText = new FlxText(220, 210, 300, "Press Enter to Continue...", true);
			text.size = 14;
			add(text);
		}
		
		//Waits for input to go to the stage.
		override public function update():void
		{
			if (FlxG.keys.ENTER)
			{
				FlxG.switchState(new PlayState());
			}
		}
	}

}
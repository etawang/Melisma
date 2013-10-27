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
		//Raw String Input.
		public var rawData:String = "";
		
		
		//music management
		protected var myMusic:MusicAnalyzer;
		
		public function LoadState()
		{
			
		}
		
		override public function create():void
		{
			//Initialize after load.
			var text:FlxText = new FlxText(220, 210, 300, "Press Enter to Continue...", true);
			text.size = 14;
			add(text);
			
			//collect beat info for a song
			myMusic = new MusicAnalyzer();
		}
		
		//Waits for input to go to the stage.
		override public function update():void
		{
			if (FlxG.keys.ENTER && myMusic.audioIsLoaded())
			{
				FlxG.switchState(new PlayState(myMusic));
			}
		}
	}

}
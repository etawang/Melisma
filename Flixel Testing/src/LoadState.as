package
{
	import org.flixel.*;
	import org.flixel.system.FlxList;
	import flash.display.LoaderInfo;
	/**
	 * ...
	 * @author Celestics
	 */
	public class LoadState extends FlxState
	{	
		//Raw String Input.
		public var rawData:String = "";
		
		public var tune:String;
		public var events:String;
		
		protected var originalTime:int = FlxU.getTicks();
		
		//music management
		protected var myMusic:MusicAnalyzer;
		
		public function LoadState()
		{
			var params:Object = LoaderInfo(FlxG.stage.root.loaderInfo).parameters;
			if (params.tune != null && params.events != null) {
				tune = params.tune.toString();
				events = params.events.toString();
			}
			else {
				tune = null;
				events = null;
			}
		}
		
		override public function create():void
		{
			//Initialize after load.
			var screenWidth:uint = FlxG.width;
			var screenHeight:uint = FlxG.height;
			
			var text:FlxText = new FlxText((screenWidth/2)-75, (screenHeight/2), 150, "Loading", true);
			text.setFormat(null, 24, 0xFFFFFF, "center");
			add(text);
			
			//collect beat info for a song
			myMusic = new MusicAnalyzer();
		}
		
		//Waits for input to go to the stage.
		override public function update():void
		{
			if (myMusic.audioIsLoaded() && (FlxU.getTicks()>=(originalTime+3000)))
			{
				FlxG.switchState(new PlayState(myMusic, tune, events));
			}
		}
	}

}
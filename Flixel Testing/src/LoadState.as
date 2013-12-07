package
{
	import org.flixel.*;
	import org.flixel.system.FlxList;
	import flash.events.*;
	import flash.net.*;
	import com.adobe.serialization.json.JSON;
	
	/**
	 * ...
	 * @author Celestics
	 */
	public class LoadState extends FlxState
	{	
		//Raw String Input.
		public var rawData:String = "";
		
		protected var originalTime:int = FlxU.getTicks();
		
		//music management
		protected var myMusic:MusicAnalyzer;
		
		protected var beats:Array;
		
		private var dataLoaded:Boolean = false;
		
		public function LoadState()
		{
			
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
			//var file:File = File.documentsDirectory;
			//file = file.resolvePath("datafile.txt");
			//var fileStream:FileStream = new FileStream();
			//fileStream.open(file, FileMode.READ);
			
			var myTextLoader:URLLoader = new URLLoader();

			myTextLoader.addEventListener(Event.COMPLETE, onLoaded);

			myTextLoader.load(new URLRequest("events.txt"));
		}
		
		function onLoaded(e:Event):void {
			
			beats = (int)(e.target.data.split(/\n/));
			dataLoaded = true;
			
		}
			
		//Waits for input to go to the stage.
		override public function update():void
		{
			if (!dataLoaded) {
				return;
			}
			
			if (myMusic.audioIsLoaded() && (FlxU.getTicks()>=(originalTime+3000)))
			{
				FlxG.switchState(new PlayState(myMusic, beats));
			}
		}
	}

}
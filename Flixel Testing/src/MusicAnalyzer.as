package 
{
	import org.flixel.*;
	import flash.events.*;

	/**
	 * ...
	 * @author ...
	 */
	public class MusicAnalyzer
	{
		private var myALF:ALF;
		private var isLoaded:Boolean = false;
		private var beats:Array;
		private var w:Array = [1, 1, 1, 1, 1, 1, 1]; //couldn't figure out what the first argument for getBeats is supposed to be
		
		public function MusicAnalyzer() {
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters.tune;
			var s:String = String(paramObj);
			//var s:String = "Test.mp3";
			myALF = new ALF(s, 0, 60, false, 20);
			myALF.addEventListener(myALF.FILE_LOADED, setIsLoaded);
			myALF.addEventListener(myALF.FILE_COMPLETE, audioFinished);
			//beats = myALF.getBeats(w, 1);
		}
		
		public function audioIsLoaded():Boolean {
			return isLoaded;
		}
		
		public function playSong():void {
			myALF.startAudio();
		}
		
		public function stopSong():void {
			myALF.stopAudio();
		}
		
		public function returnBeats():Array {
			//trace("beats " + myALF.getBeats(w, 1)[0].toString());
			return myALF.getBeats(w,1);
		}
		
		private function audioFinished(event:Event):void {
			FlxG.switchState(new WinState());
		}
		
		private function setIsLoaded(event:Event):void {
			isLoaded = true;
		}
		
	}
	
}
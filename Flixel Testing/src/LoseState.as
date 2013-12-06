package  
{
	import org.flixel.*;
	
	public class LoseState extends FlxState
	{
		protected var _winner:Lose;
		
		//Lose Screen.
		private static var loseImg:Lose;
		private var TEXTa:FlxText;
		private var restart:FlxText;
		
		public function LoseState(myMusic:MusicAnalyzer) 
		{
			FlxG.bgColor = 0xFF0044DD;
			var width:Number = FlxG.width;
			var height:Number = FlxG.height;
			
			loseImg = new Lose(width/2,50);
			add(loseImg);
			
			TEXTa = new FlxText((width/2)-250, (height/2), 500, "YOU LOST!", true);
			restart = new FlxText((width/2)-100, (height/2)+200, 200, "(Enter to Restart)", true);
			
			TEXTa.setFormat(null, 18, 0xFFFFFF, "center", 0x0033FF);
			restart.setFormat(null, 18, 0xFFFFFF, "center", 0x0033FF);
						
			add(TEXTa);
			add(restart);
			myMusic.stopSong();
			
		}
		
		override public function update():void
		{
			if (FlxG.keys.ENTER)
			{
				FlxG.switchState(new MenuState());
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			loseImg = null;
		}
	}

}
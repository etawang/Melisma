package  
{
	import org.flixel.*;
	
	public class WinState extends FlxState
	{
		protected var _winner:Win;
		
		//Win Screen.
		private static var winImg:Win;
		private var TEXTa:FlxText;
		private var restart:FlxText;
		
		public function WinState() 
		{
			FlxG.bgColor = 0xFF0044DD;
			var width:Number = FlxG.width;
			var height:Number = FlxG.height;
			
			winImg = new Win(width/2,50);
			add(winImg);
			
			TEXTa = new FlxText((width/2)-250, (height/2), 500, "YOU WON!", true);
			restart = new FlxText((width/2)-100, (height/2)+200, 200, "(Enter to Restart)", true);
			
			TEXTa.setFormat(null, 18, 0xFFFFFF, "center", 0x0033FF);
			restart.setFormat(null, 18, 0xFFFFFF, "center", 0x0033FF);
						
			add(TEXTa);
			add(restart);
			
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
			winImg = null;
		}
	}

}
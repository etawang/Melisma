package  
{
	import org.flixel.*;
	import org.flixel.system.FlxList;
	
	/**
	 * ...
	 * @author Celestics
	 */
	public class MenuState extends FlxState
	{
		public var buttons:Array;
		public var currentButton:int;

		override public function create():void
		{
			FlxG.mouse.show();
			
			//Initialize after load.
			var screenWidth:int = FlxG.width;
			var screenHeight:int = FlxG.height;
			
			var title:FlxText = new FlxText((screenWidth/2)-100, (screenHeight/2)-150, 200, "Melisma", true);
			title.setFormat(null, 38, 0xFFFFFF, "center", 0x0033FF);
			add(title);
			
			currentButton = 0;
			
			var play:FlxText = new FlxText((screenWidth / 2) - 100, (screenHeight / 2), 200, "PLAY", true);
			play.setFormat(null, 18, 0xFFFFFF, "center", 0x000000);
			add(play);
			
			var instructions:FlxText = new FlxText((screenWidth / 2) - 100, (screenHeight / 2) + 75, 200, "INSTRUCTIONS", true);
			instructions.setFormat(null, 18, 0xFFFFFF, "center", 0x000000);
			add(instructions);
			
			buttons = [play, instructions];
			
			
			//add(play);
			//var playButton:FlxButton = new FlxButton((screenWidth / 2), (screenHeight / 2), "Play", play);
			//add(playButton);	
		}
		
		
		override public function update():void
		{
			var len:int = buttons.length;
			
			if (FlxG.keys.ENTER || FlxG.mouse.justPressed() )
			{
				//Hacky; fix later
				if (currentButton == 0)
				{
					play();
				}
				if (currentButton == 1)
				{
					instructions();
				}
			}
			else if (FlxG.keys.DOWN)
			{
				if (currentButton < len - 1)
				{
					currentButton++;
				}
				//else 
				//{
					//currentButton = 0;
				//}
			}
			else if (FlxG.keys.UP)
			{
				if (currentButton > 0)
				{
					currentButton--;
				}
				//else
				//{
					//currentButton = buttons.length;
				//}
			}
			
			var mouseX:int = FlxG.mouse.x;
			var mouseY:int = FlxG.mouse.y;
			
			for (var i:int = 0; i < len; i++) {
				var b:FlxText = buttons[i];
				if (mouseX >= b.x && mouseX <= b.x + b.width && mouseY >= b.y && mouseY <= b.y + b.height)
				{
					currentButton = i;
					break;
				}
			}
			
			for (var i:int = 0; i < len; i++) {
				if (i == currentButton) {
					buttons[i].setFormat(null, 20, 0x66AAFF, "center", 0x66AAFF);
				}
				else 
				{
					buttons[i].setFormat(null, 18, 0xFFFFFF, "center", 0x000000);
				}
			}
		}
		
		public function play():void
		{
			FlxG.switchState(new LoadState());
		}
		
		public function options():void
		{
			FlxG.switchState(new OptionMenu());
		}
		
		public function instructions():void
		{
			FlxG.switchState(new Instructions());
		}
	}

}
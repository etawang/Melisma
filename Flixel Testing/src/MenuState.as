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
		public var buttonFuncs:Array;
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
			
			var playButton:FlxText = new FlxText((screenWidth / 2) - 100, (screenHeight / 2), 200, "PLAY", true);
			playButton.setFormat(null, 18, 0xFFFFFF, "center", 0x000000);
			add(playButton);
			
			var instructionsButton:FlxText = new FlxText((screenWidth / 2) - 100, (screenHeight / 2) + 75, 200, "INSTRUCTIONS", true);
			instructionsButton.setFormat(null, 18, 0xFFFFFF, "center", 0x000000);
			add(instructionsButton);
			
			buttons = [playButton, instructionsButton];
			buttonFuncs = [play, instructions];
		}
		
		
		override public function update():void
		{
			var cb = buttons[currentButton];
			
			if (FlxG.keys.justPressed("ENTER") || (FlxG.mouse.justPressed() && mouseInBox(cb.x, cb.x + cb.width, cb.y , cb.y + cb.height)))
			{
				var func:Function = buttonFuncs[currentButton];
				if (func != null) func();
			}
			else if (FlxG.keys.DOWN)
			{
				if (currentButton < buttons.length - 1)
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
					//currentButton = buttons.length-1;
				//}
			}
			
			updateButtons();
		}
		
		public function updateButtons():void
		{
			var len:int = buttons.length;
			
			for (var i:int = 0; i < len; i++) {
				var b:FlxText = buttons[i];
				if (mouseInBox(b.x, b.x + b.width, b.y , b.y + b.height))
				{
					currentButton = i;
					break;
				}
			}
			
			for (var j:int = 0; j < len; j++) {
				if (j == currentButton) {
					buttons[j].setFormat(null, 20, 0x66AAFF, "center", 0x66AAFF);
				}
				else 
				{
					buttons[j].setFormat(null, 18, 0xFFFFFF, "center", 0x000000);
				}
			}
		}
		
		public function mouseInBox(left:Number, right:Number, top:Number, bottom:Number):Boolean
		{
			var mouseX:int = FlxG.mouse.x;
			var mouseY:int = FlxG.mouse.y;
			
			if (mouseX >= left && mouseX <= right && mouseY >= top && mouseY <= bottom) return true;
			else return false;
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
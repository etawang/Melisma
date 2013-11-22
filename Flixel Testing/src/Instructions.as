package 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author junhuo
	 */
	public class Instructions extends FlxState
	{
		var menuButton:FlxText;
		
		override public function create():void
		{
			var screenWidth:int = FlxG.width;
			var screenHeight:int = FlxG.height;
			
			var title:FlxText = new FlxText(10, 10, 300, "Instructions", true);
			title.setFormat(null, 24, 0xFFFFFF, "left", 0x0033FF);
			add(title);
			var ctrltitle:FlxText = new FlxText(10, 250, 300, "Controls", true);
			ctrltitle.setFormat(null, 24, 0xFFFFFF, "left", 0x0033FF);
			add(ctrltitle);
			
			
			var s:String =
				"Try to survive until the end of the song by avoiding the floor and fire!\n\n" +
				"Press the correct arrow key as it passes through the diamond to prevent the fire from approaching...\n\n" +
				"...while jumping along notes to avoid falling to your death! You get 3 tries. Good luck!\n";
			var text:FlxText = new FlxText(30, title.y+50, 480, s, true);
			text.setFormat(null, 14, 0xFFFFFF, "left");
			add(text);
			var ctrls:String =
				"ARROW CONTROLS - UP, DOWN, LEFT, RIGHT\n\n" +
				"JUMP - SPACE\n";
			var textctrl:FlxText = new FlxText(30, ctrltitle.y+50, 480, ctrls, true);
			textctrl.setFormat(null, 14, 0xFFFFFF, "left");
			add(textctrl);
			
			//Button for Main Menu
			menuButton = new FlxText(440, screenHeight - 50, 400, "To Main Menu", true);
			menuButton.setFormat(null, 20, 0xFFFFFF, "left", 0xFF0000);
			add(menuButton);
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("ENTER") || (FlxG.mouse.justPressed() && mouseInBox(menuButton.x, menuButton.x + menuButton.width, menuButton.y , menuButton.y + menuButton.height)))
			{
				playMenu();
			}
			
			if (mouseInBox(menuButton.x, menuButton.x + menuButton.width, menuButton.y, menuButton.y+menuButton.height))
			{
				menuButton.setFormat(null, 20, 0x66AAFF, "left", 0x66AAFF);
			}
			else
			{
				menuButton.setFormat(null, 20, 0xFFFFFF, "left", 0xFF0000);
			}
		}
		
		public function playMenu():void
		{
			FlxG.switchState(new MenuState());
		}
		
		public function mouseInBox(left:Number, right:Number, top:Number, bottom:Number):Boolean
		{
			var mouseX:int = FlxG.mouse.x;
			var mouseY:int = FlxG.mouse.y;
			
			if (mouseX >= left && mouseX <= right && mouseY >= top && mouseY <= bottom)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	}
}
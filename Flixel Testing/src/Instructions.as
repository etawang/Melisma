package 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author junhuo
	 */
	public class Instructions extends FlxState
	{
		override public function create():void
		{
			var screenWidth = FlxG.width;
			var screenHeight = FlxG.height;
			
			var title:FlxText = new FlxText((screenWidth/2)-100, (screenHeight/2)-150, 200, "Melisma", true);
			title.setFormat(null, 38, 0xFFFFFF, "center", 0x0033FF);
			add(title);
			
			
			var s = "Instructions go here \n or other stuff, if preferred";
			var text:FlxText = new FlxText((screenWidth / 2) - 150, (screenHeight / 2), 300, s, true);
			text.setFormat(null, 14, 0xFFFFFF, "center");
			add(text);
			
			//Button for Main Menu
		}
		
		override public function update():void
		{

		}
		
		public function play():void
		{

		}
	}
	
}
package 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author junhuo
	 */
	public class OptionMenu extends FlxState
	{
		override public function create():void
		{
			var screenWidth:int = FlxG.width;
			var screenHeight:int = FlxG.height;
			
			var title:FlxText = new FlxText((screenWidth/2)-100, (screenHeight/2)-150, 200, "Melisma", true);
			title.setFormat(null, 38, 0xFFFFFF, "center", 0x0033FF);
			add(title);
			
			var text:FlxText = new FlxText((screenWidth / 2) - 150, (screenHeight / 2), 300, "Option stuff go here", true);
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
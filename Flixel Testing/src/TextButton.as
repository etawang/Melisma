/* This is failing because I can't seem to get the mouse events to bind (I think).
 * I'll scrap this later when we polish up our project. Keeping it here for now.
 * - Jun
 */


package
{
	import org.flixel.*;
	import flash.events.MouseEvent;
	
	public class TextButton extends FlxText
	{
		public var _flxText:FlxText;
		
		static public var _left:Number;
		static public var _top:Number;
		static public var _right:Number;
		static public var _bottom:Number;
		
		public var _fontOnOut:String;
		public var _sizeOnOut:Number;
		public var _colorOnOut:uint;
		public var _alignOnOut:String;
		public var _shadowOnOut:uint;
		
		public var _fontOnOver:String;
		public var _sizeOnOver:Number;
		public var _colorOnOver:uint;
		public var _alignOnOver:String;
		public var _shadowOnOver:uint;
		
		public var _fontOnDown:String;
		public var _sizeOnDown:Number;
		public var _colorOnDown:uint;
		public var _alignOnDown:String;
		public var _shadowOnDown:uint;
		
		public var _func:Function;
		
		public var _selected:Boolean;
		
		public var _mouseX:Number;
		public var _mouseY:Number;
		public var _justPressed:Boolean;
		public var _justReleased:Boolean;
		
		public function TextButton (X:Number, Y:Number, Width:uint, Text:String = null, EmbeddedFont:Boolean = true, Func:Function = null)
		{
			super(X, Y, Width, Text, EmbeddedFont);

			_left = X;
			_top = Y;
			_right = X + Width;
			_bottom = Y + _textField.height;
			
			_func = Func;
			
			_selected = false;
			
			_mouseX = 0;
			_mouseY = 0;
			_justPressed = false;
			_justReleased = false;
		}
		
		public function setOnOut(newFont:String = null, newSize:Number = 8, newColor:uint = 0xFFFFFF, newAlign:String = null, newShadow:uint = 0):void
		{
			_fontOnOut = newFont;
			_sizeOnOut = newSize;
			_colorOnOut = newColor;
			_alignOnOut = newAlign;
			_shadowOnOut = newShadow;
		}
		
		public function setOnOver(newFont:String = null, newSize:Number = 8, newColor:uint = 0xFFFFFF, newAlign:String = null, newShadow:uint = 0):void
		{
			_fontOnOver = newFont;
			_sizeOnOver = newSize;
			_colorOnOver = newColor;
			_alignOnOver = newAlign;
			_shadowOnOver = newShadow;
		}
		
		public function setOnDown(newFont:String = null, newSize:Number = 8, newColor:uint = 0xFFFFFF, newAlign:String = null, newShadow:uint = 0):void 
		{
			_fontOnDown = newFont;
			_sizeOnDown = newSize;
			_colorOnDown = newColor;
			_alignOnDown = newAlign;
			_shadowOnDown = newShadow;
		}
		
		public function onOut():void 
		{
			setFormat(_fontOnOut, _sizeOnOut, _colorOnOut, _alignOnOut, _shadowOnOut);
			_selected = false;
		}
		
		public function onOver():void
		{
			setFormat(_fontOnOver, _sizeOnOver, _colorOnOver, _alignOnOver, _shadowOnOver);
			_selected = true;
		}
		
		public function onDown():void
		{
			setFormat(_fontOnDown, _sizeOnDown, _colorOnDown, _alignOnDown, _shadowOnDown);
		}
		
		public function onUp():void
		{
			if (_func != null)
			{
				_func();
			}
		}
		
		public function updateInBox(justPressed:Boolean, justReleased:Boolean):void {
			if (justPressed) 
			{
				onDown();
			}
			else if (justReleased)
			{
				onUp();
			}
			_selected = true;
		}
		
		public function updateOutBox():void {
			onOut();
			_selected = false;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (_mouseX >= _left && _mouseX <= _right && _mouseY >= _top && _mouseY <= _bottom) {
				updateInBox(_justPressed, _justReleased);
			}
			else 
			{
				updateOutBox();
			}
		}
		
		public function mouseInBox(mouseX:Number, mouseY:Number):Boolean
		{
			if (mouseX >= _left && mouseX <= _right && mouseY >= _top && mouseY <= _bottom) {
				return true;
			}
			else 
			{
				return false;
			}
		}
		
		public function mouseUpdate(mouseX:Number, mouseY:Number, justPressed:Boolean, justReleased:Boolean):void
		{
			_mouseX = mouseX;
			_mouseY = mouseY;
			_justPressed = justPressed;
			_justReleased = justReleased;
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			_func = null;
		}
	}
}

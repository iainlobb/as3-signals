package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.osflash.signals.natives.NativeSignal;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@googlemail.com
	 */
	public class SignalButton extends MovieClip
	{
		public var mouseDown:Signal;
		private var nativeMouseDown:NativeSignal;
		
		public var rollOver:Signal;
		private var nativeRollOut:NativeSignal;
		
		public var rollOut:Signal;
		private var nativeRollOver:NativeSignal;
		
		
		public function SignalButton() 
		{
			mouseChildren = false;
			buttonMode = true;
			useHandCursor = true;
			
			graphics.beginFill(0xFF0000);
			graphics.drawRect(0, 0, 200, 80);
			
			nativeRollOver = new NativeSignal(this, MouseEvent.ROLL_OVER);
			nativeRollOver.add(onRollOver);
			rollOver = new Signal();
			
			nativeRollOut = new NativeSignal(this, MouseEvent.ROLL_OUT);
			nativeRollOut.add(onRollOut);
			rollOut = new Signal();
			
			nativeMouseDown = new NativeSignal(this, MouseEvent.MOUSE_DOWN);
			nativeMouseDown.add(onMouseDown);
			mouseDown = new Signal();
		}
		
		protected function onRollOver(event:MouseEvent):void
		{
			rollOver.dispatch();
		}
		
		protected function onRollOut(event:MouseEvent):void
		{
			rollOut.dispatch();
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			mouseDown.dispatch();
		}
		
	}
	
}
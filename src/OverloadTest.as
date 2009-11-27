package  
{
	import flash.display.Sprite;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@googlemail.com
	 */
	public class OverloadTest extends Sprite
	{
		private var button1:SignalButton;
		private var button2:SignalButton;
		private var button3:SignalButton;
		
		private var outputField:TextField;
		
		public function OverloadTest() 
		{
			button1 = new SignalButton();
			button2 = new SignalButton();
			button3 = new SignalButton();
			
			button1.y = 100;
			button2.y = 200;
			button3.y = 300;
			
			addChild(button1);
			addChild(button2);
			addChild(button3);
			
			button1.mouseDown.overload(traceNumber, 1);
			button2.mouseDown.overload(traceNumber, 2);
			button3.mouseDown.overload(traceNumber, 3);
			
			//button1.mouseDown.add(traceNumber);
			
			outputField = new TextField();
			outputField.x = 300;
			outputField.y = 200;
			addChild(outputField);
		}
		
		private function traceNumber(number:Number = 0):void
		{
			outputField.text = "The number is " + number;
			
			//throw new Error();
			//trace("The number is", number);
		}
		
	}

}
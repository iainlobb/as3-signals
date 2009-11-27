package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Iain Lobb - iainlobb@googlemail.com
	 */
	public class Main extends Sprite 
	{
		private var overloadTest:OverloadTest;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			overloadTest = new OverloadTest();
			addChild(overloadTest);
		}
		
	}
	
}
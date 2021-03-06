package org.osflash.signals.natives
{
	import asunit.asserts.*;

	import asunit4.async.addAsync;

	import org.osflash.signals.IDeluxeSignal;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;

	public class NativeSignalTest
	{
		private var clicked:NativeSignal;
		private var sprite:IEventDispatcher;

		[Before]
		public function setUp():void
		{
			sprite = new Sprite();
			clicked = new NativeSignal(sprite, 'click', MouseEvent);
		}

		[After]
		public function tearDown():void
		{
			// tearDown() is getting called too early for some reason, so commenting out for now.
			//clicked.removeAll();
			//clicked = null;
		}
		
		protected function verifyNoListeners():void
		{
			assertFalse('the EventDispatcher should not have listeners for the event', sprite.hasEventListener('click'));
			assertEquals('the NativeSignal should have no listeners', 0, clicked.numListeners);
		}
		//////
		public function testInstantiated():void
		{
			assertTrue("NativeSignal instantiated", clicked is NativeSignal);
			assertTrue('implements IDeluxeSignal', clicked is IDeluxeSignal);
			assertTrue('implements INativeDispatcher', clicked is INativeDispatcher);
			assertFalse('sprite has no click event listener to start', sprite.hasEventListener('click'));
			assertSame('target round-trips through constructor', sprite, clicked.target);
		}
		//////
		[Test(async)]
		public function signal_add_then_EventDispatcher_dispatch_should_call_signal_listener():void
		{
			clicked.add( addAsync(onClicked) );
			sprite.dispatchEvent(new MouseEvent('click'));
		}
		
		private function onClicked(e:MouseEvent):void
		{
			assertSame(sprite, e.currentTarget);
		}
		//////
		[Test]
		public function when_signal_adds_listener_then_target_should_have_listener():void
		{
			clicked.add(emptyHandler);
			assertEquals(1, clicked.numListeners);
			assertTrue(sprite.hasEventListener('click'));
		}
		
		private function emptyHandler(e:MouseEvent):void {}
		
		[Test]
		public function when_signal_adds_then_removes_listener_then_target_should_not_have_listeners():void
		{
			clicked.add(emptyHandler);
			clicked.remove(emptyHandler);
			verifyNoListeners();
		}
		
		[Test]
		public function when_signal_removes_all_listeners_then_target_should_not_have_listeners():void
		{
			clicked.add(emptyHandler);
			clicked.add( function(e:*):void {} );
			clicked.removeAll();
			verifyNoListeners();
		}
		
		[Test]
		public function when_addOnce_and_removeAll_listeners_then_target_should_not_have_listeners():void
		{
			clicked.addOnce(emptyHandler);
			clicked.addOnce( function(e:*):void {} );
			clicked.removeAll();
			verifyNoListeners();
		}
		//////
		[Test(async)]
		public function addOnce_and_dispatch_from_signal_should_remove_listener_automatically():void
		{
			clicked.addOnce( addAsync(emptyHandler) );
			clicked.dispatch(new MouseEvent('click'));
			verifyNoListeners();
		}
		//////
		[Test(async)]
		public function addOnce_normal_priority_and_dispatch_from_EventDispatcher_should_remove_listener_automatically():void
		{
			var normalPriority:int = 0;
			clicked.addOnce( addAsync(emptyHandler) , normalPriority);
			sprite.dispatchEvent(new MouseEvent('click'));
			verifyNoListeners();
		}
		//////
		[Test(async)]
		public function addOnce_lowest_priority_and_dispatch_from_EventDispatcher_should_remove_listener_automatically():void
		{
			var lowestPriority:int = int.MIN_VALUE;
			clicked.addOnce( addAsync(emptyHandler) , lowestPriority);
			sprite.dispatchEvent(new MouseEvent('click'));
			verifyNoListeners();
		}
		//////
		[Test(async)]
		public function addOnce_highest_priority_and_dispatch_from_EventDispatcher_should_remove_listener_automatically():void
		{
			var highestPriority:int = int.MAX_VALUE;
			clicked.addOnce( addAsync(emptyHandler) , highestPriority);
			sprite.dispatchEvent(new MouseEvent('click'));
			verifyNoListeners();
		}
		//////
		[Test]
		public function adding_listener_without_args_should_throw_ArgumentError():void
		{
			assertThrows(ArgumentError, addListenerWithoutArgs);
		}
		
		private function addListenerWithoutArgs():void
		{
			clicked.add(noArgs);
		}
		
		private function noArgs():void
		{
		}
		//////
		[Test]
		public function adding_listener_with_two_args_should_throw_ArgumentError():void
		{
			assertThrows(ArgumentError, addListenerWithTwoArgs);
		}
		
		private function addListenerWithTwoArgs():void
		{
			clicked.add(twoArgs);
		}
		
		private function twoArgs(a:*, b:*):void
		{
		}
		//////
		[Test]
		public function dispatch_wrong_event_class_should_throw_ArgumentError():void
		{
			assertThrows(ArgumentError, dispatchWrongEventClass);
		}
		
		private function dispatchWrongEventClass():void
		{
			clicked.dispatch(new Event('click'));
		}
		//////
		[Test]
		public function dispatch_event_with_type_not_matching_signal_name_should_throw_ArgumentError():void
		{
			assertThrows(ArgumentError, dispatchWrongEventType);
		}
		
		private function dispatchWrongEventType():void
		{
			var wrongType:String = 'rollOver';
			clicked.dispatch(new MouseEvent(wrongType));
		}
		//////
		[Test]
		public function dispatch_null_should_throw_ArgumentError():void
		{
			assertThrows(ArgumentError, dispatchNonEventObject);
		}
		
		private function dispatchNonEventObject():void
		{
			clicked.dispatch(null);
		}
		//////
		[Test]
		public function eventClass_defaults_to_native_Event_class():void
		{
			var added:NativeSignal = new NativeSignal(sprite, 'added');
			assertSame(Event, added.eventClass);
		}
	}
}

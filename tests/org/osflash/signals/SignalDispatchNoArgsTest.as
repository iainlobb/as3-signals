package org.osflash.signals
{
	import asunit.asserts.*;

	import asunit4.async.addAsync;

	public class SignalDispatchNoArgsTest
	{
		public var completed:Signal;

		[Before]
		public function setUp():void
		{
			completed = new Signal();
		}

		[After]
		public function tearDown():void
		{
			completed.removeAll();
			completed = null;
		}
		//////
		[Test(async)]
		public function dispatch_no_args_should_call_listener_with_no_args():void
		{
			completed.add( addAsync(onCompleted, 10) );
			completed.dispatch();
		}
		
		private function onCompleted():void
		{
			assertEquals(0, arguments.length);
		}
		
	}
}

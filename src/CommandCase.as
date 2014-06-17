package
{
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import ninedays.command.IQueue;
	import ninedays.command.Queue;
	import ninedays.command.QueueEvent;
	
	import test.command.TestCommand;

	public class CommandCase extends ninedaysCase
	{
		public function CommandCase()
		{
			super();
			
			var prev:int = getTimer();
			var queue:IQueue = new Queue();
			
			for(var i:int = 0; i < 10; i++)
			{
				var command:TestCommand = new TestCommand(i + "");
				queue.addChild(command);
			}
			
			queue.execute();
			queue.addEventListener(QueueEvent.QUEUE_COMPLETE, onQueueCompleteHandle);
			queue.addEventListener(QueueEvent.CHILD_COMPLETE, onChildComplete);
			trace("运行毫秒数:" + (getTimer() - prev));
		}
		
		private function onQueueCompleteHandle(event:Event):void
		{
			trace("queue has completed!");
		}
		
		private function onChildComplete(event:QueueEvent):void
		{
			trace("id:" + event.child.id + " has completed!");
		}
	}
}
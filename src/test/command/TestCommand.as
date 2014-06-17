package test.command
{
	import ninedays.command.Command;
	import ninedays.command.DelayCommand;
	
	public class TestCommand extends DelayCommand
	{
		public function TestCommand(id:String)
		{
			this._id = id;
			super(1000);
		}
		
		override protected function doExecute():void
		{
			trace(_id);
			complete();
		}
	}
}
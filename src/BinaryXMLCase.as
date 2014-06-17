package
{
    import flash.utils.ByteArray;
    import flash.utils.getTimer;
    
    import ninedays.command.QueueEvent;
    import ninedays.data.BinaryXML;
    import ninedays.loading.QueueLoader;

    public class BinaryXMLCase extends ninedaysCase
    {
        private var _loader:QueueLoader;
		
		[Embed(source="/assets/tasks.bx",mimeType="application/octet-stream")]
		private static var tasksXMLCLass:Class;

        public function BinaryXMLCase()
        {
            _loader = new QueueLoader();
            _loader.maxExecuting = 1;
            _loader.load("assets/tasks.xml", "tasks");
            _loader.addEventListener(QueueEvent.QUEUE_COMPLETE, onLoaded);
        }

        private function onLoaded(event:QueueEvent):void
        {
            var xml:XML = _loader.getXML("tasks");

            var prevTime:int = getTimer();
            var bxml:BinaryXML = new BinaryXML();
            bxml.importXML(xml);
            trace("xml--BinaryXML运行毫秒数：" + (getTimer() - prevTime));
            prevTime = getTimer();
            var bytes:ByteArray = bxml.exportByteArray();
            trace("BinaryXML--bytes运行毫秒数：" + (getTimer() - prevTime));
            trace("BinaryXML has:" + int(bytes.length / 1024) + "kbs");
            prevTime = getTimer();

            bytes.position = 0;
            var newXML:BinaryXML = new BinaryXML();
            newXML.importByteArray(bytes);
            trace("bytes--BinaryXML运行毫秒数：" + (getTimer() - prevTime));
			
			prevTime = getTimer();
			bytes = (new tasksXMLCLass()) as ByteArray;
			newXML.importByteArray(bytes);
			trace("bytes--BinaryXML运行毫秒数：" + (getTimer() - prevTime));
        }
    }
}
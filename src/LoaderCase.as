package
{
	import flash.display.MovieClip;
	import flash.net.FileReference;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	import flash.utils.getTimer;
	
	import ninedays.command.QueueEvent;
	import ninedays.component.treeClasses.BranchNode;
	import ninedays.component.treeClasses.LeafNode;
	import ninedays.component.treeClasses.RootNode;
	import ninedays.component.treeClasses.TNode;
	import ninedays.component.treeClasses.TreeDataProvider;
	import ninedays.data.BinaryXML;
	import ninedays.loading.QueueLoader;
	import ninedays.loading.QueueLoaderProgressEvent;
	import ninedays.loading.items.LoaderItem;
	import ninedays.loading.items.SWFItem;

	public class LoaderCase extends ninedaysCase
	{
		private var _loader:QueueLoader;
		public function LoaderCase()
		{
			var prev:int = getTimer();
			
			_loader = new QueueLoader();
			_loader.maxExecuting = 1;
			_loader.load("assets/map1.png", "map");
			_loader.destroyAllChildren();
			_loader.load("assets/20.swf", "avatar");
			_loader.load("assets/tasks.xml", "tasks");
			_loader.load("assets/hello.json", "json");
			
			_loader.addEventListener(QueueEvent.QUEUE_COMPLETE, onLoaded);
			_loader.addEventListener(QueueLoaderProgressEvent.PROGRESS, onProgress);
			
			trace("运行毫秒数:" + (getTimer() - prev));
		}
		
		private function onProgress(event:QueueLoaderProgressEvent):void
		{
			var loader:LoaderItem = event.loadingLoader;
			trace(loader.id + "加载百分比" + int(loader.bytesLoaded / loader.bytesTotal * 100));
			trace("queueLoader加载百分比" + int(event.bytesLoaded / event.bytesTotal * 100));
		}
		
		private function onLoaded(event:QueueEvent):void
		{
			var loader:SWFItem = _loader.getLoader("avatar") as SWFItem;
			var movie:MovieClip = loader.getMovieClip("Move");
//			var movie:MovieClip = _loader.getMovieClip("avatar", "Move");
			addChild(movie);
			movie.play();
			movie.x = 200;
			movie.y = 200;
			
			var xml:XML = _loader.getXML("tasks");
			
//			var bytes:ByteArray = new ByteArray();
//			bytes.writeObject(xml);
//			bytes.compress();
//			trace("node has:" + int(bytes.length / 1024) + "kbs");
//			
//			var prevTime:int = getTimer();
//			bytes.uncompress();
//			xml = bytes.readObject() as XML;
//			trace("bytes--xml运行毫秒数：" + (getTimer() - prevTime));
			
			
			var json:Object = _loader.getJsonObj("json");
			trace("队列加载完成！");
			_loader.destroy();
			
			var prevTime:int = getTimer();
			var nxml:BinaryXML = new BinaryXML();
			nxml.importXML(xml);
			trace("xml--node运行毫秒数：" + (getTimer() - prevTime));
			prevTime = getTimer();
			var bytes:ByteArray = nxml.exportByteArray();
			trace("node--bytes运行毫秒数：" + (getTimer() - prevTime));
			prevTime = getTimer();
			
			bytes.position = 0;
			var newXML:BinaryXML = new BinaryXML();
			newXML.importByteArray(bytes);
			trace("bytes--node运行毫秒数：" + (getTimer() - prevTime));
			
			bytes.compress();
			trace("node has:" + int(bytes.length / 1024) + "kbs");
//			var file:FileReference = new FileReference();
//			file.save(bytes, "tasks.bx");
			
			bytes = new ByteArray();
			bytes.writeObject(xml);
			bytes.compress(CompressionAlgorithm.DEFLATE);
			trace("compressed xml has:" + int(bytes.length / 1024) + "kbs");
			prevTime = getTimer();
			bytes.position = 0;
			bytes.uncompress(CompressionAlgorithm.DEFLATE);
			xml = bytes.readObject() as XML;
			trace("bytes--xml运行毫秒数：" + (getTimer() - prevTime));
		}
	}
}
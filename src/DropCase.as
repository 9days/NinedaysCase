package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import ninedays.astar.AStar;
	import ninedays.astar.AStarMap;
	import ninedays.astar.AStarNode;
	import ninedays.input.KeyPoll;
	import ninedays.utils.FilterUtils;
	import ninedays.utils.drag.DragEvent;
	import ninedays.utils.drag.DragHelper;

	[SWF(backgroundColor=0x555555, frameRate="30", width="800", height="760")]
	public class DropCase extends ninedaysCase
	{
		[Embed(source="/assets/scale9.png")]
		public var port:Class;
		
		private var dragSource:Sprite; 
		private var dragHelper:DragHelper;
		private var targetArea:Sprite;
		
		public function DropCase()
		{
			dragSource = new Sprite();
			addChild(dragSource);
			var bitmap:Bitmap = new port() as Bitmap;
			dragSource.x = 200;
			dragSource.y = 100;
			dragSource.addChild(bitmap);
			
			dragHelper = new DragHelper(dragSource);
			
			targetArea = new Sprite;
			addChild(targetArea);
			targetArea.x = 500;
			targetArea.y = 100;
			targetArea.filters = FilterUtils.GRAY_FILTER;
			targetArea.addChild(new Bitmap(bitmap.bitmapData));
			targetArea.addEventListener(DragEvent.Drop, onDropHandle);
		}
		
		private function onDropHandle(event:DragEvent):void
		{
			targetArea.filters = [];
			dragHelper.destroy();
		}
	}
}
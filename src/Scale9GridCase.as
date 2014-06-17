package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import ninedays.display.Scale9GridBitmap;
	import ninedays.ui.Stats;

	[SWF(backgroundColor = 0x555555, frameRate = "30", width = "1250", height = "760")]
	public class Scale9GridCase extends Sprite
	{
		[Embed(source="/assets/scale9.png")]
		public var port:Class;
		
		private var isMouseDown:Boolean;
		
		private var scale9Bitmap:Scale9GridBitmap 
		
		public function Scale9GridCase()
		{
			//stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			addChild(new Stats());
			
			var bitmap:Bitmap = new port() as Bitmap;
			var bitmapData:BitmapData = bitmap.bitmapData;
			addChild(bitmap);
			bitmap.x = 200;
			bitmap.y = 200;
			bitmap.width = 400;
			bitmap.height = 400;
			
			scale9Bitmap = new Scale9GridBitmap(bitmapData, new Rectangle(35,35,10,10));
			addChild(scale9Bitmap);
			scale9Bitmap.x = scale9Bitmap.y = 50;
			
			scale9Bitmap.width = 400;
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		public function onMouseUp(event:MouseEvent) : void
		{
			isMouseDown = false;
		}
		
		
		public function onMouseDown(event:MouseEvent) : void
		{
			isMouseDown = true;
		}
		
		public function onMouseMove(event:MouseEvent) : void
		{
			if (!isMouseDown)
			{
				return;
			}
			scale9Bitmap.width = event.stageX - 50;
			scale9Bitmap.height = event.stageY - 50;
		}
	}
}
package test.tooltip
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import ninedays.display.BaseToolTip;
	import ninedays.display.Scale9GridBitmap;
	
	public class TestToolTip extends BaseToolTip
	{
		[Embed(source="/assets/scale9.png")]
		private var port:Class;
		
		protected var label:TextField;
		
		protected var backgroud:Scale9GridBitmap;
		
		public function TestToolTip()
		{
			backgroud = new Scale9GridBitmap((new port() as Bitmap).bitmapData, new Rectangle(35,35,10,10));
			addChild(backgroud);
			
			label = new TextField();
			label.textColor = 0xFFFFFF;
			label.wordWrap = true;
			label.multiline = true;
			label.x = 5;
			label.y = 5;
			addChild(label);
		}
		
		override public function initData(tipData:Object):void
		{
			var tips:String = String(tipData);
			
			label.width = 100;
			
			label.htmlText = tips;
			label.width = label.textWidth + 5;
			label.height = label.textHeight + 5;
			
			backgroud.width = 2 * label.x + label.width;
			backgroud.height = 2 * label.y + label.height;
		}
	}
}
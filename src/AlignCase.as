package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import ninedays.data.AlignInfo;
	import ninedays.framework.Global;

	[SWF(backgroundColor=0x555555, frameRate="30", width="800", height="760")]
	public class AlignCase extends ninedaysCase
	{
		[Embed(source="/assets/scale9.png")]
		public var port:Class;
		
		private var _ui:Sprite; 
		
		public function AlignCase()
		{
			_ui = new Sprite();
			addChild(_ui);
			var bitmap:Bitmap = new port() as Bitmap;
			_ui.addChild(bitmap);
			
			var alignInfo:AlignInfo = new AlignInfo();
			alignInfo.right = 150;
			alignInfo.bottom = 100;
			Global.layerManager.uiLayer.appendChild(_ui, alignInfo);
		}
	}
}
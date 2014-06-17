package
{
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import ninedays.framework.Global;
	import ninedays.managers.LayerManager;
	import ninedays.ui.Stats;

	public class ninedaysCase extends Sprite
	{
		public function ninedaysCase()
		{
//			MonsterDebugger.initialize(this);
//			MonsterDebugger.trace(this, "Hello World!");
//			MonsterDebugger.log(this);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			if (CONFIG::debug)
				stage.addChild(new Stats());
			else
			{
				trace(0);
			}
			
			Global.layerManager = new LayerManager();
			Global.layerManager.setup(this);
		}
	}
}
package
{
	import ninedays.component.Button;
	import ninedays.component.ToggleButton;
	import ninedays.component.defaultSkin.ComponentEntry;
	import ninedays.display.mediator.IButtonSelectable;
	import ninedays.framework.Global;
	import ninedays.managers.ToolTipManager;
	
	import test.tooltip.TestToolTip;

	[SWF(backgroundColor=0x555555, frameRate="30", width="1250", height="760")]
	public class ToolTipCase extends ninedaysCase
	{
		public function ToolTipCase()
		{
			new ComponentEntry().setup();
			
			var group:Vector.<IButtonSelectable> = new Vector.<IButtonSelectable>();
			for (var i:int = 0; i < 20; i++)
			{
				var btn:ToggleButton = new ToggleButton();
				Global.layerManager.mapLayer.addChild(btn);
				
				btn.x = 70 + 150 * (i % 4);
				btn.y = 20 + 60 * int(i / 4)
				
				btn.height = 50;
				
				btn.label = "test";
				group.push(btn);
				
				btn.setStyle("overColor", 0x999999);
				
				ToolTipManager.regester(btn, "hello world!该tips会延迟" + (i * 100) + "ms", null, i * 100);
				
				if(i > 10)
				{
					ToolTipManager.regester(btn, "这是特殊制作的tips !该tips会延迟" + ((i - 10) * 100) + "ms", TestToolTip, (i - 10) * 100);
				}
			}
		}
	}
}
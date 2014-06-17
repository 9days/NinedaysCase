package com.gf.app
{
	import com.gf.core.manager.MapManager;
	
	import flash.display.Sprite;

	public class MainEntry
	{
		public function MainEntry()
		{
		}
		
		public function setup(root:Sprite):void
		{
			MapManager.changeMap(1);
		}
	}
}
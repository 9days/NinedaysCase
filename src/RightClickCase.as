package
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    import ninedays.component.defaultSkin.ComponentEntry;
    import ninedays.framework.Global;
    import ninedays.managers.ContextMenuManager;
    import ninedays.ui.contextMenu.BaseContextMenuPanel;
    import ninedays.ui.contextMenu.ContextMenu;
    import ninedays.ui.contextMenu.ContextMenuItem;

    [SWF(backgroundColor=0x555555, frameRate="30", width="800", height="760")]
    public class RightClickCase extends ninedaysCase
    {
        private var board:Sprite;

        public function RightClickCase()
        {
			new ComponentEntry().setup();
            board = new Sprite();
            board.graphics.beginFill(0xFF0000, 1);
            board.graphics.drawRoundRect(0, 0, 100, 100, 20, 20);
            board.graphics.endFill();
			Global.layerManager.popupLayer.addChild(board);
			board.x = board.y = 100;
			
			
			var menu:ContextMenu = new ContextMenu();
			var item:ContextMenuItem = new ContextMenuItem("hello world");
			menu.addItem(item);
			item = new ContextMenuItem("打开XX");
			menu.addItem(item);
			item = new ContextMenuItem("复制");
			menu.addItem(item);
			item = new ContextMenuItem("粘贴");
			menu.addItem(item);
			
			ContextMenuManager.instance.regester(board, menu);
        }
    }
}
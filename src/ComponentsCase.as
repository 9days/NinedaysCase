package
{
    import com.greensock.events.LoaderEvent;
    import com.greensock.loading.ImageLoader;
    import com.greensock.loading.LoaderMax;
    import com.greensock.loading.display.ContentDisplay;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.utils.setInterval;
    import flash.utils.setTimeout;
    
    import ninedays.component.Button;
    import ninedays.component.Label;
    import ninedays.component.List;
    import ninedays.component.ScrollBar;
    import ninedays.component.ScrollPane;
    import ninedays.component.ToggleButton;
    import ninedays.component.Tree;
    import ninedays.component.defaultSkin.ComponentEntry;
    import ninedays.component.events.ScrollEvent;
    import ninedays.component.listClasses.ItemRenderer;
    import ninedays.component.treeClasses.TNode;
    import ninedays.component.treeClasses.TreeDataProvider;
    import ninedays.data.DataProvider;
    import ninedays.display.mediator.IButtonSelectable;
    import ninedays.display.mediator.RadioGroup;
    import ninedays.events.ValueChangeEvent;

    [SWF(backgroundColor=0x555555, frameRate="30", width="1250", height="760")]
    public class ComponentsCase extends ninedaysCase
    {
        private var image:Bitmap;

        private var scrollBar:ScrollBar;

        private var tree:Tree;

        public function ComponentsCase()
        {
            new ComponentEntry().setup();
            var group:Vector.<IButtonSelectable> = new Vector.<IButtonSelectable>();
            for (var i:int = 0; i < 10; i++)
            {
                var btn:ToggleButton = new ToggleButton();
                addChild(btn);

                btn.x = 70 + 150 * (i % 4);
                btn.y = 20 + 60 * int(i / 4)

                btn.height = 50;

                btn.label = "test";
                group.push(btn);

                btn.setStyle("overColor", 0x999999);
            }

            var radio:RadioGroup = new RadioGroup(group);
            radio.addEventListener(ValueChangeEvent.VALUE_CHANGE, valueChanged);


            /*scrollBar = new ScrollBar(ScrollBar.VERTICAL);
               scrollBar.height = 400;
               scrollBar.lineScrollSize = 5;
               addChild(scrollBar);
               scrollBar.x = 100;
               scrollBar.y = 50;
               //			scrollBar.addEventListener(ScrollEvent.SCROLL, scrollHandle);

               var loaderQueue:LoaderMax = new LoaderMax({name: "loaderQueue", onComplete: onCompleteHandle});
               loaderQueue.append(new ImageLoader("assets/map1.png", {name: "map"}));
             loaderQueue.load();*/

            creatList();
            creatTree();
        }


        private function creatList():void
        {
            var list:List = new List(100, 200);
            list.itemRendererClass = ItemRenderer;
            addChild(list);
            list.x = 70;
            list.y = 200;

            var vScrollBar:ScrollBar = new ScrollBar(ScrollBar.VERTICAL);
            list.verticalScrollBar = vScrollBar;
            addChild(vScrollBar);

			vScrollBar.x = 55;
			vScrollBar.y = 200;
            vScrollBar.height = 200;

            var array:Array = [ "listItem0", "listItem1", "listItem2", "listItem3", 
									"listItem4", "listItem5", "listItem6", "listItem7", 
									"listItem8", "listItem9", "listItem10", "listItem11", 
									"listItem12", "listItem13", "listItem14", "listItem15" ];
            var dataProvider:DataProvider = new DataProvider(array);
            list.dataProvider = dataProvider;
        }

        private function creatTree():void
        {
            var xml:XML = <node>  
                    <node label = "我的好友">  
                        <node label = "同学">  
                            <node label = "初中同学">
                                <node label = "老王" />
                                <node label = "张三" />
                                <node label = "同桌">
                                    <node label = "李四" />
                                    <node label = "王五" />
                                    <node label = "赵六" />
                                </node>
                                <node label = "班主任" />
                            </node>  
                            <node label = "大学同学"/>  
                        </node>  
                        <node label = "同事">  
                            <node label = "老板"/>  
                            <node label = "老板娘" />  
                        </node>  
                        <node label = "哈哈">  
                            <node label = "九天之后"/>  
                        </node>  
                    </node>     
                    <node label = "网友">  
                        <node label = "妹纸1号"/>  
                        <node label = "妹纸2号"/>  
                        <node label = "妹纸3号"/>  
                    </node>  
                    <node label = "猎头">  
                        <node label = "猎头女一号"/>  
                        <node label = "猎头男一号"/>  
                    </node>  
                    <node label = "家人">  
                        <node label = "老爸"/>
                        <node label = "老妈"/>
                        <node label = "兄弟姐们">  
                            <node label = "哥哥"/>  
                            <node label = "妹妹"/>  
                        </node>  
                    </node>  
                </node>

            tree = new Tree(200, 150);
//            tree.dataProvider = new TreeDataProvider(xml);
			tree.xml = xml;
            addChild(tree);

            tree.x = 200;
            tree.y = 200;
			
			var openAllNodeBtn:Button = new Button();
			openAllNodeBtn.label = "打开所有节点";
			addChild(openAllNodeBtn);
			openAllNodeBtn.x = 410;
			openAllNodeBtn.y = 200;
			openAllNodeBtn.addEventListener(MouseEvent.CLICK, openAllNodeHandle);
			
			function openAllNodeHandle(event:MouseEvent):void
			{
				tree.openAllNodes();
			}
			
			
			var closeAllNodesBtn:Button = new Button();
			closeAllNodesBtn.label = "关闭所有节点";
			addChild(closeAllNodesBtn);
			closeAllNodesBtn.x = 410;
			closeAllNodesBtn.y = 230;
			closeAllNodesBtn.addEventListener(MouseEvent.CLICK, closeAllNodesHandle);
			
			function closeAllNodesHandle(event:MouseEvent):void
			{
				tree.closeAllNodes();
			}
			
			
			
			var findBtn:Button = new Button();
			findBtn.label = "查找九天之后";
			addChild(findBtn);
			findBtn.x = 410;
			findBtn.y = 260;
			findBtn.addEventListener(MouseEvent.CLICK, findHandle);
			
			function findHandle(event:MouseEvent):void
			{
				var foundNode:TNode = tree.findNode("label", "九天之后");
				var nodeIndex:int = tree.showNode(foundNode);
				tree.selectedIndex = nodeIndex;
				tree.scrollToSelected();
			}
        }

        private function onCompleteHandle(event:LoaderEvent):void
        {
            var imageLoader:ImageLoader = LoaderMax.getLoader("map") as ImageLoader;
            var imageData:BitmapData = (imageLoader.content as ContentDisplay).rawContent["bitmapData"];


            image = new Bitmap(imageData);
//			addChildAt(image, 0);

            //scrollBar.addEventListener(ScrollEvent.SCROLL, scrollHandle);

//			image.scrollRect = new Rectangle(0, 0, 400, 300);
            scrollBar.minValue = 0;
            scrollBar.maxValue = image.height - 300;

            var scrollPane:ScrollPane = new ScrollPane(400, 300);
            scrollPane.width = 400;
            scrollPane.height = 300;
            scrollPane.addChild(image);
            scrollPane.setContentSize(image.width, image.height);
            scrollPane.verticalScrollBar = scrollBar;

            var hScrollBar:ScrollBar = new ScrollBar(ScrollBar.HORIZONTAL);
            scrollPane.horizontalScrollBar = hScrollBar;
            addChild(hScrollBar);

            addChildAt(scrollPane, 0);
        }

        private function scrollHandle(event:ScrollEvent):void
        {
            image.scrollRect = new Rectangle(0, event.position, 400, 300);
            trace(event.position, event.oldPosition, event.percent);
        }

        private function valueChanged(event:ValueChangeEvent):void
        {
            trace(event.oldValue, event.newValue);
        }
    }
}
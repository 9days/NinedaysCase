package
{
    import ninedays.behaviorTree.SelectorNode;
    import ninedays.component.ToggleButton;
    import ninedays.component.defaultSkin.ComponentEntry;

    /**
     *
     * @author 9days
     */
    [SWF(backgroundColor=0x000000, frameRate="30", width="1250", height="760")]
    public class BehaviorTreeCase extends ninedaysCase
    {
        private var _pos:Array = [[ 200, 100 ], [ 500, 100 ], [ 200, 500 ], [ 500, 500 ]];

        private var _names:Array = [ "篮球场", "自己家", "女友家", "花店" ];

        private var _places:Array;

        private var _btn0:ToggleButton;

        private var _btn1:ToggleButton;

        private var _btn2:ToggleButton;

        private var _btn3:ToggleButton;

        private var _btn4:ToggleButton;

        private var _rootNode:SelectorNode;

        public function BehaviorTreeCase()
        {
            new ComponentEntry().setup();

            _places = [];
            for (var i:int = 0; i < _names.length; i++)
            {
                var p:Place = new Place(_names[i]);
                p.x = _pos[i][0];
                p.y = _pos[i][1];
                addChild(p);
                _places[i] = p;
            }

            _btn0 = new ToggleButton();
            _btn0.label = "带钱了";
            addChild(_btn0);
            _btn0.x = 20;
            _btn0.y = 150;

            _btn1 = new ToggleButton();
            _btn1.label = "有花了";
            addChild(_btn1);
            _btn1.x = 20;
            _btn1.y = 200;

            _btn2 = new ToggleButton();
            _btn2.label = "女友还在";
            addChild(_btn2);
            _btn2.x = 20;
            _btn2.y = 250;

            _btn3 = new ToggleButton();
            _btn3.label = "女友有花了";
            addChild(_btn3);
            _btn3.x = 20;
            _btn3.y = 300;

            _btn4 = new ToggleButton();
            _btn4.label = "是情人节";
            addChild(_btn4);
            _btn4.x = 20;
            _btn4.y = 350;

            _rootNode = new SelectorNode();
        }

        public function get hasFlower():Boolean
        {
            return _btn1.selected;
        }

        public function set hasFlower(value:Boolean):void
        {
            _btn1.selected = value;
        }

        public function get hasMoneyInPocket():Boolean
        {
            return _btn0.selected;
        }

        public function set hasMoneyInPocket(value:Boolean):void
        {
            _btn0.selected = value;
        }

        public function get gfHasFlower():Boolean
        {
            return _btn3.selected;
        }

        public function set gfHasFlower(value:Boolean):void
        {
            _btn3.selected = value;
        }
    }
}
import flash.display.Sprite;
import flash.text.TextField;


class Place extends Sprite
{
    private var _label:TextField;

    public function Place(name:String)
    {
        graphics.beginFill(0xffffff * Math.random());
        graphics.drawRect(0, 0, 80, 80);
        graphics.endFill();

        _label = new TextField();
        _label.text = name;
        addChild(_label);
    }
}
package test.behaviorTree.player
{
    import com.greensock.TweenLite;
    import com.greensock.easing.Linear;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;

    /**
     *
     * @author 9days
     */
    public class Player extends Sprite
    {
        public static var instance:Player = new Player();

        private var _state:String;
		
		private var _main:BehaviorTreeCase;

        public function Player(main:BehaviorTreeCase)
        {
			_main = main;
            graphics.beginFill(0xFF0000);
            graphics.drawCircle(0, 0, 50);
            graphics.endFill();
        }

        public function moveTo(p:Point, desName:String = ""):void
        {
            var time:Number = (Point.distance(new Point(this.x, this.y), p) / 50);
            if (time >= 0.01)
            {
                TweenLite.to(this, time, { x: p.x, y: p.y, onComplete: this.onComplete, ease: Linear.easeNone });
                this._state = "moving";
            }
            else
            {
                this.onComplete();
            }
            if (((!((desName == ""))) && ((time >= 0.01))))
            {
                trace(("移动到" + desName));
            }
        }

        public function buyFlower():void
        {
            trace("买花");
            _main.hasFlower = true;
			_main.hasMoneyInPocket = false;
            this._state = "buy flower";
        }

        public function sendFlower():void
        {
            trace("送花给女友");
			_main.hasFlower = false;
			_main.gfHasFlower = true;
            this._state = "send flower";
        }

        public function playBall():void
        {
            if (this._state != "play ball")
            {
                trace("打球");
            }
            this._state = "play ball";
        }

        public function takeMoney():void
        {
            trace("拿钱");
            _main.hasMoneyInPocket = true;
            this._state = "take money";
        }

        private function onComplete():void
        {
            this.dispatchEvent(new Event(Event.COMPLETE));
        }

    }
}
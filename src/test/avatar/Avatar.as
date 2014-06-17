package test.avatar
{
	import ninedays.display.BitmapFrame;
	import ninedays.display.BitmapMovie;

	public class Avatar extends BitmapMovie
	{
		public static const STAND:int = 1;
		public static const RUN:int = 2;



		protected var restFrames:Vector.<BitmapFrame>;
		protected var moveFrames:Vector.<BitmapFrame>;

		protected var state:int;
		
		protected var standLastFrame:int;
		protected var runLastFrame:int;
		
		
		protected var _inScreen:Boolean = true;


		public function Avatar(standFrames:Vector.<BitmapFrame>, runFrames:Vector.<BitmapFrame>)
		{
			standLastFrame = standFrames.length;
			runLastFrame = standLastFrame + runFrames.length;
			this.restFrames = standFrames;
			this.moveFrames = runFrames;
			super(standFrames);

			state = STAND;
		}
		
		
		public function startMove():void
		{
			if(state != RUN)
			{
				frameList = moveFrames;
			}
			play();
			state = RUN;
		}


		public function stopMove():void
		{
			if(state != STAND)
			{
				frameList = restFrames;
			}
			play();
			state = STAND;
		}

		override protected function onTick(interval:int):void
		{
			if (state == STAND)
			{
				if (_currentFrame >= standLastFrame)
				{
					_currentFrame = 0;
				}
			}
			else if (state == RUN)
			{
				if (_currentFrame < standLastFrame || _currentFrame >= runLastFrame)
				{
					_currentFrame = standLastFrame;
				}
			}

			super.onTick(interval);
		}
		
		override protected function get needPaint():Boolean
		{
			return super.needPaint && _inScreen;
		} 
		
		
		public function set inScreen(value:Boolean):void
		{
			_inScreen = value;
		}
	}
}

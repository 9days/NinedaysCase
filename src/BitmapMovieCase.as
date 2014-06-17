package
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.getTimer;
	
	import ninedays.display.BitmapFrame;
	import ninedays.display.BitmapMovie;
	import ninedays.managers.BitmapMovieManager;
	import ninedays.ui.Stats;
	
	import test.avatar.Avatar;

	[SWF(backgroundColor = 0x000000, frameRate = "30", width = "1250", height = "760")]
	public class BitmapMovieCase extends Sprite
	{
		public function BitmapMovieCase()
		{
			addChild(new Stats());
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			var loaderQueue:LoaderMax = new LoaderMax({name: "loaderQueue", onComplete: onCompleteHandle, onError:errorHandler});
			//loaderQueue.append(new SWFLoader("E:/聚位/dragonsoul/asset/asset/model/20.swf", {name: "xiahouyuan"}));
			loaderQueue.append(new ImageLoader("assets/smap.png", {name: "smap"}));
			loaderQueue.load();
		}


		private function onCompleteHandle(event:LoaderEvent):void
		{
			/*var swfLoader:SWFLoader = LoaderMax.getLoader("xiahouyuan") as SWFLoader;
			var moveClass:Class = swfLoader.getClass("Move");
			var move:MovieClip = new moveClass();
			var restClass:Class = swfLoader.getClass("Rest");
			var rest:MovieClip = new restClass();


			BitmapMovieManager.instance.registerByMovieClip(move, "avatarMove");
			BitmapMovieManager.instance.registerByMovieClip(rest, "avatarRest");
			
			var moveFrames:Vector.<BitmapFrame> = BitmapMovieManager.instance.getBitmapFrames("avatarMove");
			var restFrames:Vector.<BitmapFrame> = BitmapMovieManager.instance.getBitmapFrames("avatarRest");
			
			
			var movie:BitmapMovie = new BitmapMovie(moveFrames);

			for (var i:int = 0; i < 100; i++)
			{
				var movie2:BitmapMovie = movie.clone()
				addChild(movie2)
				movie2.x = i / 3 * 60 + 100
				movie2.y = i % 3 * 100 + 100;
				movie2.gotoAndPlay(Math.random() * movie2.totalFrames + 1 >> 0);
				movie2.scaleX = Math.random() > 0.5 ? 1 : -1;
			}*/
			
			var imageLoader:ImageLoader =  LoaderMax.getLoader("smap") as ImageLoader;
			var image:BitmapData = (imageLoader.content as ContentDisplay).rawContent["bitmapData"];
			
			BitmapMovieManager.instance.registerByBitmap(image, 8, 23, "smap");
			var movie:BitmapMovie = BitmapMovieManager.instance.getBitmapMovie("smap");
			
			for (var i:int = 0; i < 300; i++)
			{
				var movie2:BitmapMovie = movie.clone();
				addChild(movie2.content)
				movie2.content.x = i / 8 * 60 + 0
				movie2.content.y = i % 8 * 100 + 0;
				movie2.gotoAndPlay(Math.random() * movie2.totalFrames + 1 >> 0);
				movie2.speed = Math.random();
			}
		}
		
		
		private function errorHandler(event:LoaderEvent):void
		{
			trace("error occured with " + event.target + ": " + event.text);
		}
	}
}

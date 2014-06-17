package
{
	import com.greensock.TweenLite;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.utils.getTimer;
	
	import ninedays.display.BitmapFrame;
	import ninedays.display.BitmapMovie;
	import ninedays.managers.BitmapMovieManager;
	import ninedays.ui.Stats;
	
	import test.avatar.Avatar;
	import test.scene.Scene;

	[SWF(backgroundColor = 0x000000, frameRate = "30", width = "1250", height = "760")]
	public class SceneCase extends ninedaysCase
	{
		private var avatar:Avatar;


		public function SceneCase()
		{
			var loaderQueue:LoaderMax = new LoaderMax({name: "loaderQueue", onComplete: onCompleteHandle, onError: errorHandler});
			loaderQueue.append(new SWFLoader("assets/20.swf", {name: "xiahouyuan"}));
//			loaderQueue.append(new SWFLoader("assets/4120453.swf", {name: "4120453"}));
			loaderQueue.append(new ImageLoader("assets/map1.png", {name: "map"}));
			loaderQueue.load();
		}


		private function onCompleteHandle(event:LoaderEvent):void
		{
			var swfLoader:SWFLoader = LoaderMax.getLoader("xiahouyuan") as SWFLoader;
			var moveClass:Class = swfLoader.getClass("Move");
			var move:MovieClip = new moveClass();
			var restClass:Class = swfLoader.getClass("Rest");
			var rest:MovieClip = new restClass();
			
			var prevTime:int = getTimer();


			BitmapMovieManager.instance.registerByMovieClip(move, "avatarMove");
			BitmapMovieManager.instance.registerByMovieClip(rest, "avatarRest");

			var moveFrames:Vector.<BitmapFrame> = BitmapMovieManager.instance.getBitmapFrames("avatarMove");
			var restFrames:Vector.<BitmapFrame> = BitmapMovieManager.instance.getBitmapFrames("avatarRest");


			avatar = new Avatar(restFrames, moveFrames);
			addChild(avatar.content);
			avatar.gotoAndPlay(1);
			avatar.content.x = 200;
			avatar.content.y = 200;
			
			avatar.content.filters = [new GlowFilter(0xff0000)];
			
			
			var imageLoader:ImageLoader =  LoaderMax.getLoader("map") as ImageLoader;
			var image:BitmapData = (imageLoader.content as ContentDisplay).rawContent["bitmapData"];
			
			
			var scene:Scene = new Scene(new Bitmap(image));
			scene.addRole(avatar);
			addChildAt(scene, 0);
			
//			prevTime = getTimer();
			
			for (var i:int = 0; i < 1000; i++) 
			{
				var role:Avatar = new Avatar(restFrames, moveFrames);
				scene.addRole(role, false);
				role.content.x = Math.random() * 1250;
				role.content.y = Math.random() * 700;
				role.gotoAndPlay(1);
				role.speed = Math.random() * 5;
			}
			
			trace("addRole cost time: " + (getTimer() - prevTime) + " ms!");
			
			scene.sortAllAvatar();
			scene.checkInScreen();
			
			
//			swfLoader = LoaderMax.getLoader("4120453") as SWFLoader;
//			addChild(swfLoader.content as DisplayObject);
			
//			prevTime = getTimer();
//			BitmapMovieManager.instance.registerByMovieClip((swfLoader.content as ContentDisplay).rawContent as MovieClip, "4120453");
//			var movie:BitmapMovie = BitmapMovieManager.instance.getBitmapMovie("4120453");
//			movie.gotoAndPlay(1);
//			addChild(movie.content);
//			trace("add effect movie cost: " + (getTimer() - prevTime) + " ms");
		}

		private function errorHandler(event:LoaderEvent):void
		{
			trace("error occured with " + event.target + ": " + event.text);
		}
	}
}

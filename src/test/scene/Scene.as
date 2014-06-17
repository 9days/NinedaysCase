package test.scene
{
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import ninedays.core.Tick;
	import ninedays.framework.Global;
	import ninedays.managers.LayerManager;
	import ninedays.utils.DepthSort;
	
	import test.avatar.Avatar;

	public class Scene extends Sprite
	{
		public var content:DisplayObject;

		/**人物层**/
		protected var _roleLayer:Sprite;

		protected var _camera:Rectangle;
		protected var _size:Rectangle;

		/**自己**/
		protected var self:Avatar;

		/**行走终点**/
		protected var endX:int;
		protected var endY:int;

		
		/**人物**/
		protected var roles:Array;
		
		protected var depthSort:DepthSort;


		public function Scene(skin:DisplayObject)
		{
			content = skin;

			addChild(content);

			_size = new Rectangle(0, 0, content.width, content.height);

			_roleLayer = new Sprite();
			addChild(_roleLayer);
			depthSort = new DepthSort(_roleLayer);

			Global.layerManager.stage.addEventListener(Event.RESIZE, render);


			addEventListener(MouseEvent.CLICK, onMouseClick);

			roles = [];
		}

		protected function onMouseClick(event:MouseEvent):void
		{
			moveTo(content.mouseX, content.mouseY);
		}


		/**
		 * 移动到点 
		 * @param x
		 * @param y
		 * 
		 */		
		public function moveTo(x:int, y:int):void
		{
			TweenLite.killTweensOf(self);
			self.startMove();

			endX = x;
			endY = y;

			self.content.scaleX = endX > self.content.x ? 1 : -1;

			Tick.instance.register(moving);
		}

		protected function moving(interval:int):void
		{
			var dis:int = Math.sqrt((endX - self.content.x) * (endX - self.content.x) + (endY - self.content.y) * (endY - self.content.y));

			var num:int = 0;
			if (Math.abs(endX - self.content.x) > 5)
			{
				self.content.x += 4 * (endX > self.content.x ? 1 : -1);
				num++;
			}
			if (Math.abs(endY - self.content.y) > 5)
			{
				self.content.y += 4 * (endY > self.content.y ? 1 : -1);
				num++;
			}
			if (num == 0)
			{
				self.content.x = endX;
				self.content.y = endY;
				Tick.instance.unregister(moving);
				self.stopMove();
			}
			render();
		}


		protected function render(e:Event = null):void
		{
			var sw:int = Global.layerManager.stage.stageWidth;
			var sh:int = Global.layerManager.stage.stageHeight;

			var totalWidth:int = _size.width;
			var totalHeight:int = _size.height;

			var _x:int = self.content.x - sw * 0.5;
			var _y:int = self.content.y - sh * 0.5;

			if (_x + sw > totalWidth)
				_x = totalWidth - sw;

			if (_x < 0)
				_x = 0;


			if (_y + sh > totalHeight)
				_y = totalHeight - sh;

			if (_y < 0)
				_y = 0;

			scrollRect = new Rectangle(_x, _y, sw > totalWidth ? totalWidth : sw, sh > totalHeight ? totalHeight : sh);

			depthSort.reset(self.content);
//			sortRole();
//			checkInScreen();
		}


		/**
		 * 人物深度排序 
		 * 
		 */		
		protected function sortRole():void
		{
			var max:int = roles.length;

			roles.sortOn("y", Array.NUMERIC);

			var role:Avatar;


			while (max--)
			{
				role = roles[max];

				_roleLayer.setChildIndex(role.content, max);
			}
		}
		
		public function checkInScreen():void
		{
			var max:int = roles.length;
			
			var role:Avatar;
			
			
			while (max--)
			{
				role = roles[max];
				
				role.inScreen = scrollRect.contains(role.x, role.y);
			}
		}


		public function set camera(value:Rectangle):void
		{
			_camera = value;
		}


		public function get size():Rectangle
		{
			return _size;
		}


		/**
		 * 添加人物 
		 * @param role
		 * @param isSelf	是否是自己
		 * 
		 */		
		public function addRole(role:Avatar, isSelf:Boolean = true):void
		{
			if (isSelf)
			{
				self = role;
				render();
			}
			_roleLayer.addChild(role.content);
			depthSort.add(role.content);

			roles.push(role);
		}
		
		
		public function sortAllAvatar():void
		{
			sortRole();
		}
	}
}

package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import ninedays.astar.AStar;
	import ninedays.astar.AStarMap;
	import ninedays.astar.AStarNode;
	
	[SWF(backgroundColor=0x555555, frameRate="60", width="800", height="760")]
	public class AStarCase extends ninedaysCase
	{
		private var _cellSize:int = 4;
		private var cols:int = 199;
		private var rows:int = 115;
		
		private var _grid:AStarMap;
		
		private var _player:Sprite;
		
		private var _index:int;
		
		private var _path:Array;
		
		private var tf:TextField;
		
		private var astar:AStar;
		
		private var path:Sprite = new Sprite();
		
		private var image:Bitmap = new Bitmap(new BitmapData(1, 1));
		
		private var imageWrapper:Sprite = new Sprite();
		
		
		public function AStarCase()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addChild(imageWrapper);
			imageWrapper.addChild(image);
			imageWrapper.y = 100;
			
			tf = new TextField();
			addChild(tf);
			tf.x = 100;
			tf.y = 20;
			
			makePlayer();
			imageWrapper.addEventListener(MouseEvent.CLICK, onGridClick);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			imageWrapper.addChild(path);
			makeGrid();
			
			/*setTimeout(function():void{
			astar.destroy();
			astar = null;
			_grid = null;
			trace("gc!");
			},5000);*/
		}
		
		private function newMap(e:Event):void
		{
			makeGrid();
		}
		
		private function makePlayer():void
		{
			_player = new Sprite();
			_player.graphics.beginFill(0xff00ff);
			_player.graphics.drawCircle(0, 0, 2);
			_player.graphics.endFill();
			imageWrapper.addChild(_player);
		}
		
		private function makeGrid():void
		{
			_grid = new AStarMap(cols, rows);
			
			var maze:Array = boutaoshi(rows, cols);
			/*for (var i:int = 0; i < rows * cols * Number(density.getValue()); i++){
			_grid.setWalkable(Math.floor(Math.random() * cols), Math.floor(Math.random() * rows), false);
			}*/
			
			for (var y:int = 0; y < maze.length; y++)
			{
				for (var x:int = 0; x < maze[y].length; x++)
				{
					_grid.setWalkable(x, y, maze[y][x] == 1);
				}
			}
			// _grid.setWalkable(0, 0, true);
			//_grid.setWalkable(cols / 2, rows / 2, false);
			_grid.calculateLinks(0);
			astar = new AStar(_grid);
			drawGrid();
			isClick = false;
			_player.x = 0;
			_player.y = 0;
			path.graphics.clear();
		}
		
		public function boutaoshi(numRows:int, numCols:int):Array
		{
			var maze:Array = [];
			for (var y:int = 0; y < numRows; y++)
			{
				maze[y] = [];
				for (var x:int = 0; x < numCols; x++)
				{
					if (y == 0 || x == 0 || y == numRows - 1 || x == numCols - 1 || y % 2 == 0 && x % 2 == 0)
					{
						maze[y][x] = 1;
					}
					else
					{
						maze[y][x] = 0;
					}
				}
			}
			for (y = 2; y < numRows - 1; y += 2)
			{
				var dx:int = 2;
				var dy:int = y;
				switch (int(Math.random() * 4))
				{
					case 0:
						dx++;
						break;
					case 1:
						dx--;
						break;
					case 2:
						dy++;
						break;
					case 3:
						dy--;
						break;
				}
				if (maze[dy][dx] != 1)
				{
					maze[dy][dx] = 1;
				}
				else
					y -= 2;
			}
			for (x = 4; x < numCols - 1; x += 2)
			{
				for (y = 2; y < numRows - 1; y += 2)
				{
					dx = x;
					dy = y;
					switch (int(Math.random() * 3))
					{
						case 0:
							dy++;
							break;
						case 1:
							dy--;
							break;
						case 2:
							dx++;
							break;
					}
					if (maze[dy][dx] != 1)
					{
						maze[dy][dx] = 1;
					}
					else
						y -= 2;
				}
			}
			return maze;
		}
		
		private function drawGrid():void
		{
			image.bitmapData = new BitmapData(_grid.numCols * _cellSize, _grid.numRows * _cellSize, false, 0xffffff);
			for (var i:int = 0; i < _grid.numCols; i++)
			{
				for (var j:int = 0; j < _grid.numRows; j++)
				{
					var node:AStarNode = _grid.getNode(i, j);
					if (!node.walkable)
					{
						image.bitmapData.fillRect(new Rectangle(i * _cellSize, j * _cellSize, _cellSize, _cellSize), getColor(node));
					}
				}
			}
		}
		
		private function getColor(node:AStarNode):uint
		{
			if (!node.walkable)
				return 0;
			if (node == _grid.startNode)
				return 0xcccccc;
			if (node == _grid.endNode)
				return 0xcccccc;
			return 0xffffff;
		}
		
		private function onGridClick(event:MouseEvent):void
		{
			var xpos:int = Math.floor(imageWrapper.mouseX / _cellSize);
			var ypos:int = Math.floor(imageWrapper.mouseY / _cellSize);
			xpos = Math.min(xpos, _grid.numCols - 1);
			ypos = Math.min(ypos, _grid.numRows - 1);
			_grid.setEndNode(xpos, ypos);
			xpos = Math.floor(_player.x / _cellSize);
			ypos = Math.floor(_player.y / _cellSize);
			_grid.setStartNode(xpos, ypos);
			findPath();
			path.graphics.clear();
			path.graphics.lineStyle(0, 0xff0000, 0.5);
			path.graphics.moveTo(_player.x, _player.y);
		}
		
		private function findPath():void
		{
			var time:int = getTimer();
			if (astar.findPath())
			{
				time = getTimer() - time;
				tf.text = time + "ms   length:" + astar.path.length;
				_path = astar.path;
				_index = 0;
				isClick = true;
			}
			else
			{
				time = getTimer() - time;
				tf.text = time + "ms 找不到";
			}
		}
		
		private var isClick:Boolean = false;
		
		
		private function onEnterFrame(event:Event):void
		{
			if (!isClick)
			{
				return;
			}
			var targetX:Number = _path[_index].x * _cellSize + _cellSize / 2;
			var targetY:Number = _path[_index].y * _cellSize + _cellSize / 2;
			
			
			
			
			/*_index++;
			if (_index >= _path.length)
			{
				isClick = false;
			}
			_player.x = targetX;
			_player.y = targetY;
			path.graphics.lineTo(targetX, targetY);
			
			
			return;*/
			
			
			
			
			var dx:Number = targetX - _player.x;
			var dy:Number = targetY - _player.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			if (dist < 5)
			{
				_index++;
				if (_index >= _path.length)
				{
					isClick = false;
				}
			}
			else
			{
				_player.x += dx * .5;
				_player.y += dy * .5;
				path.graphics.lineTo(_player.x, _player.y);
			}
			
			
			var sw:int = stage.stageWidth;
			var sh:int = stage.stageHeight;
			
			var totalWidth:int = cols * _cellSize;
			var totalHeight:int = rows * _cellSize;
			
			var _x:int = targetX - sw * 0.5;
			var _y:int = targetY - sh * 0.5;
			
			if (_x + sw > totalWidth)
				_x = totalWidth - sw;
			
			if (_x < 0)
				_x = 0;
			
			
			if (_y + sh > totalHeight)
				_y = totalHeight - sh;
			
			if (_y < 0)
				_y = 0;
			
			//scrollRect = new Rectangle(_x, _y, sw > totalWidth ? totalWidth : sw, sh > totalHeight ? totalHeight : sh);
		}
	}
}
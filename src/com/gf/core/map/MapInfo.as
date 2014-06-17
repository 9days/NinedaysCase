package com.gf.core.map
{
    import flash.geom.Point;

    public class MapInfo
    {
        /**
         * 上一个地图ID
         */
        public var prevID:uint;

        /**
         * 当前地图ID
         */
        public var id:uint;

        /**
         * 当前地图名
         */
        public var name:String = "";

        /**
         * 当前地图样式ID，比如小屋的地图ID和美术资源的地图ID是不一致，此参数表示当前美术资源的ID
         */
        public var styleID:uint;

        /**
         * 当前地图角色位置初始点
         */
        public var defaultPos:Point = new Point();

        /**
         * 当前地图的角色跳转出现点
         */
        public var gotoPos:Point = new Point();
    }
}
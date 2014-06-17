package com.gf.core.manager
{
    import com.gf.core.map.Map;
    import com.gf.core.map.MapInfo;

    import flash.events.Event;

    import ninedays.framework.Global;
    import ninedays.utils.DisplayObjectUtil;

    public class MapManager
    {
        private static var _currentMap:Map;

        private static var _newMap:Map;

        public static function changeMap(id:int):void
        {
            var mapInfo:MapInfo = new MapInfo();
            mapInfo.id = id;
            _newMap = new Map(mapInfo);
            _newMap.addEventListener(Event.COMPLETE, onNewMapLoaded);
			_newMap.load();
        }

        private static function onNewMapLoaded(event:Event):void
        {
            if (_currentMap)
            {
                _currentMap.destroy();
            }

            _newMap.removeEventListener(Event.COMPLETE, onNewMapLoaded);
            _currentMap = _newMap;

            Global.layerManager.mapLayer.addChild(_newMap.content);
        }
    }
}
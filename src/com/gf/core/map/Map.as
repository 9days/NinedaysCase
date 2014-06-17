package com.gf.core.map
{
    import com.gf.core.config.ResConfig;
    
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    
    import ninedays.loading.QueueLoader;

    public class Map extends EventDispatcher
    {
        protected var _info:MapInfo;
		protected var _content:DisplayObject;

        protected static var _loader:QueueLoader;

        public function Map(info:MapInfo)
        {
            _info = info;

            if (_loader == null)
            {
                _loader = new QueueLoader();
                _loader.maxExecuting = 1;
            }
        }

        public function load():void
        {
            _loader.load(ResConfig.mapURL + _info.id + ".swf", _info.id.toString(), onMapLoaded);
        }

        private function onMapLoaded():void
        {
			_content = _loader.getLoader(_info.id.toString()).content;
			dispatchEvent(new Event(Event.COMPLETE));
        }

        public function get content():DisplayObject
        {
			return _content;
        }

        public function destroy():void
        {
        }
    }
}
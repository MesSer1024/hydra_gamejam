package  {
	/**
	 * ...
	 * @author Daniel 'MesSer' Dahlkvist
	 */
	public class Messages {
		static private var _listeners:Array = [];

		public static function send(o:Object):void {
			for (var i:int = 0; i < _listeners.length; ++i) {
				_listeners[i].onMessage(o);
			}
		}
		
		public static function listen(me:IListener):void {
			_listeners.push(me);
		}
	}

}
package  {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Daniel 'MesSer' Dahlkvist
	 */
	public class Utils {
		public static var SpawningBounds:Rectangle;
		
		
		
		{
			SpawningBounds = new Rectangle();
			SpawningBounds.top = 100;
			SpawningBounds.bottom = 720 - 150;
			SpawningBounds.left = 550;
			SpawningBounds.right = 1280 - 300;
			trace(SpawningBounds);
		}
		
		public static function pointInsideRect(r:Rectangle):Point {
			var dx:Number = Math.random() * r.width;
			var dy:Number = Math.random() * r.height;
			return new Point(r.left + dx, r.top + dy);
		}
		
		static public function placeItemInsideBounds(content:DisplayObject, r:Rectangle):void {
			var p:Point = pointInsideRect(r);
			content.x = p.x;
			content.y = p.y;
		}
		
		static public function clamp(value:Number, min:Number, max:Number):Number {
			return Math.max(min, Math.min(max, value));
		}
		
	}

}
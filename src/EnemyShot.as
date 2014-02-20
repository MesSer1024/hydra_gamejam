package  {
	import flash.display.MovieClip;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Daniel 'MesSer' Dahlkvist
	 */
	public class EnemyShot extends MovieClip {
		public static var SPEED:Number = 5;
		public static var TIME_MODIFIER:Number = 1.25;
		private var _dir:Vector3D;
		
		public function EnemyShot(x:Number, y:Number, tar:Vector3D) {
			this.x = x;
			this.y = y;
			
			_dir = tar;
			_dir.x = tar.x - x;
			_dir.y = tar.y - y;
			_dir.normalize();
		}
		
		public function update(dt:int):void {
			if (enabled)
			{
				x += _dir.x * SPEED * TIME_MODIFIER;
				y += _dir.y * SPEED * TIME_MODIFIER;
			}
		}
		
		public function die():void {
			this.enabled = false;
		}
		
		public function collisionDetection(ship:Ship):Boolean {
			if (!enabled) return false;
			
			if (CollisionDetection.isColliding(this, ship, parent.parent, true)) {
				trace("hit enemy");
				return true;
			}
			return false;
		}
		
	}

}
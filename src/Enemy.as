package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author MesSer
	 */
	public class Enemy extends MovieClip
	{
		private var _spawnerBounds:Rectangle;
		private var _heads:Array;
		private var _nextSwitch:int;
		public var body:MovieClip;
		public var spawner:MovieClip;
		private var _goingUp:Boolean;
		private var _entering:Boolean;
		private var _tarX:Number;
		public static var TimeMultiplier:Number = 1;
		public static var MOVE_SPEED:Number = 64;
		
		public function Enemy()
		{
			_heads = new Array();
			_spawnerBounds = this.spawner.getRect(this);
			_spawnerBounds.left += 15;
			_spawnerBounds.right -= 15;
			_spawnerBounds.top += 15;
			_spawnerBounds.bottom -= 15;
			createHead();
			_nextSwitch = 0;
			_goingUp = true;
		}
		
		public function createHead(playGrowAnim:Boolean = false):void {
			var mc:MovieClip = new Head();
			Utils.placeItemInsideBounds(mc, _spawnerBounds);
			_heads.push(mc);
			this.addChild(mc);

			if (playGrowAnim) {
				mc.enabled = false;
				mc.gotoAndPlay("grow");
			}
		}
		
		public function update(dt:int):void {
			_nextSwitch -= dt;
			if (enabled == false) {
				return;
			}
			
			if (_entering) {
				x -= 8 * TimeMultiplier;
				if (x < _tarX) {
					x = _tarX;
					_entering = false;
				}
			}
			
			if (_nextSwitch < 0) {
				_goingUp = Math.random() >= 0.5;
				_nextSwitch = (1500 + Math.random() * 850);
			}
			
			y += (MOVE_SPEED * dt * 0.001 * (_goingUp ? -1 : 1));
			y = Utils.clamp(y, 10, 720 - body.height);
			for (var i:int = 0; i < _heads.length; ++i) {
				var h:Head = _heads[i];
				if (h.enabled) {
					h.update(dt);
				}
			}
		}
		
		public function handleHitTestObject(shot:Shot):Boolean {
			if (!enabled) return false;
			
			if (CollisionDetection.isColliding(this.body, shot, parent.parent, true)) {
				trace("hit body");
				alpha = 0.35;
				enabled = false;
				gotoAndPlay("die");
				for (var j:int = 0; j < _heads.length; ++j) {
					var h:Head = _heads[j];
					h.stop();
					h.enabled = false;
				}
				return true;
			} else {
				for (var i:int = 0; i < _heads.length; ++i) {
					var head:Head = _heads[i];
					if (head.enabled) {
						if (CollisionDetection.isColliding(head, shot, parent.parent, true)) {
							trace("hit head");
							head.enabled = false;
							head.stop();
							_heads.splice(i, 1);
							head.die();
							createHead(true);
							createHead(true);
							return true;
						}
					}
				}
			}
			return false;
		}
		
		public function enterScreen():void {
			_entering = true;
			_tarX = this.x;
			x = 1300;
		}
		
		private function deathCB():void {
			trace("function Enemy.deathCB()");
			Messages.send(this);
		}
	}
}
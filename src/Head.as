package  {
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Daniel 'MesSer' Dahlkvist
	 */
	public class Head extends MovieClip {
		public static var TimeMultiplier:Number = 1.33;
		private var _timeToAction:int;
		private var _timeToShot:int;
		private var _headDown:Boolean;
		
		public function Head() {
			trace("head ctor()");
			stop();
			_timeToShot = Math.random() * 850 + 2200;
			_timeToAction = Math.random() * 850 + 900;
			_headDown = false;
		}
		
		public function lowerHead():void {
			trace("lowerhead");
			gotoAndPlay("lower");
		}
		
		public function raiseHead():void {
			trace("raisehead");
			gotoAndPlay("raise");
		}
		
		public function update(dt:int):void {
			_timeToAction -= dt;
			_timeToShot -= dt;
			if (_timeToAction < 0) {
				if(_headDown)
					lowerHead();
				else
					raiseHead();
				_headDown = !_headDown;
				_timeToAction = (Math.random() * 850 + 900) * TimeMultiplier;
			}
			
			if (_timeToShot < 0) {
				_timeToShot = (Math.random() * 850 + 2586) * TimeMultiplier;
				Messages.send(this);
			}
		}
		
		public function die():void {
			inner.gotoAndPlay("die");
		}
		
		private function grownCB():void {
			trace("function Head.grownCB()");
			this.enabled = true;
		}
		
		private function deathCB():void {
			trace("function Head.deathCB()");
			//this.enabled = true;
		}
	}

}
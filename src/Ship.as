package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	/**
	 * ...
	 * @author Daniel 'MesSer' Dahlkvist
	 */
	public class Ship extends MovieClip {
		private var _timeSinceShot:int = 0;
		static public const SHOT_CD:int = 475;
		static public const ShotFired:String = "ShotFired";
		var keySPACE:Boolean = false;
		var keyUP:Boolean = false;
		var keyDOWN:Boolean = false;
		
		public function Ship() {
			trace("function Ship.Ship()");
			stage.addEventListener(KeyboardEvent.KEY_UP,key_up);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,key_Down);
		}
		
		function key_up(event:KeyboardEvent) {
			switch (event.keyCode) {
				case Keyboard.W:
				case 38 :
					keyUP = false;
					break;
				case 40 :
				case Keyboard.S:
					keyDOWN = false;
					break;
				case Keyboard.SPACE:
					keySPACE = false;
					break;
			}
		}

		function key_Down(event:KeyboardEvent) {
			switch (event.keyCode) {
				case Keyboard.W:
				case 38 :
					keyUP = true;
					break;
				case Keyboard.S:
				case 40 :
					keyDOWN = true;
					break;
				case Keyboard.SPACE:
					keySPACE = true;
					break;
			}
		}

		public function update(dt:int):void {
			_timeSinceShot += dt;
			var yDir:Number = 0;
			if (keyUP) {
				yDir -= 1;
			}
			if (keyDOWN) {
				yDir += 1;
			}
			
			if (yDir != 0) {
				this.y = (y + yDir * 5.0);
				this.y = Math.max(0, Math.min(720 - height, y));
			}
			
			if (keySPACE && _timeSinceShot >= SHOT_CD) {
				dispatchEvent(new Event(ShotFired));
				_timeSinceShot = 0;
			}
		}
		
		public function takeDamage():void {
			gotoAndPlay("dmg");
		}
		
		//private function deathCB():void {
			//trace("function Ship.deathCB()");
			//
		//}
		
	}

}
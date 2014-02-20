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
		var keyLEFT:Boolean = false;
		var keyRIGHT:Boolean = false;
		var keyUP:Boolean = false;
		var keyDOWN:Boolean = false;
		
		public function Ship() {
			trace("function Ship.Ship()");
			stage.addEventListener(KeyboardEvent.KEY_UP,key_up);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,key_Down);
		}
		
		function key_up(event:KeyboardEvent) {
			switch (event.keyCode) {
				case Keyboard.A:
				case Keyboard.LEFT:
					keyLEFT = false;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					keyRIGHT = false;
					break;
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
				case Keyboard.A:
				case Keyboard.LEFT:
					keyLEFT = true;
					break;
				case Keyboard.D:
				case Keyboard.RIGHT:
					keyRIGHT = true;
					break;
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
			var xDir:Number = 0;
			if (keyUP) {
				yDir -= 1;
			}
			if (keyDOWN) {
				yDir += 1;
			}
			
			if (keyRIGHT) {
				xDir += 1;
			}
			if (keyLEFT) {
				xDir -= 1;
			}
			
			if (yDir != 0) {
				this.y = (y + yDir * 5.0);
				this.y = Math.max(0, Math.min(720 - height, y));
			}
			if (xDir != 0) {
				this.x = (x + xDir * 5.0);
				this.x = Math.max(0, Math.min(GUI.borderLeft - width, x));
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
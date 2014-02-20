package  {
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Daniel 'MesSer' Dahlkvist
	 */
	public class Shot extends MovieClip {
		
		public function Shot() {
			trace("shot ctor()");
			stop();
		}
		
		public function update(dt:int):void {
			if(enabled)
				x += dt * 0.40;
			//if (x > 1280) {
				//this.parent.removeChild(this);
			//}
		}
		
		public function die():void {
			enabled = false;
			alpha = 0.35;
			gotoAndPlay("die");
		}
		
		private function deathCB():void {
			trace("function Shot.deathCB()");
			stop();
			this.visible = false;
			Messages.send(this);
		}
	}

}
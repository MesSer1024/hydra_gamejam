package  {
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Daniel 'MesSer' Dahlkvist
	 */
	public class GUI extends MovieClip {
		public static var hp:Number = 100;
		public static var round:Number = 1;
		static public var hydraKills:int = 0;
		static public var headKills:int = 0;
		
		private var healthBar:MovieClip;
		private var bounds:Rectangle;
		public var hptxt:TextField;
		public var roundtxt:TextField;
		public var headstxt:TextField;
		public var enemiestxt:TextField;
		
		public static var borderLeft:Number;
		
		public function GUI() {
			healthBar = this.health.bounds;
			bounds = new Rectangle(healthBar.x, healthBar.y, healthBar.width, healthBar.height);
			borderLeft = roundtxt.x;
		}
		
		public function update(dt:int):void {
			hp = Utils.clamp(hp, 0, 100);
			healthBar.width = bounds.width * (hp / 100);
			hptxt.text = "" + hp + " / " + 100;
			roundtxt.text = round.toString();
			enemiestxt.text = hydraKills.toString();
			headstxt.text = headKills.toString();
		}
	}

}
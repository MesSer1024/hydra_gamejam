package
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author MesSer
	 */
	public class ContentAsserter
	{
		
		public function ContentAsserter()
		{
			
		}
		
		public static function assertContent(mc:MovieClip, ... paths):void {
			if (!mc) {
				throw new Error("mc was null!");
			}
			
			for (var i:int = 0; i < paths.length; i++)
			{
				var parts:Array = String(paths[i]).split(".");
				if (parts.length == 1) {
					verifyContent(parts[0], mc);
				} else {
					var s:String = "";
					var lastMC:MovieClip = mc;
					for (var j:int = 0; j < parts.length; j++)
					{
						verifyContent(parts[j], lastMC);
						lastMC = lastMC[parts[j]];
					}
				}
			}
		}
		
		static private function verifyContent(name:String, lastMC:MovieClip):void
		{
			if (lastMC && lastMC[name])
			{
				trace("verified [" + name + "] on mc=" + lastMC.name);
			} else {
				throw new Error("Missing content " + name + ", on item:" + lastMC.name);
			}
		}
	}

}
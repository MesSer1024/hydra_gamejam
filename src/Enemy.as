package  
{
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author MesSer
	 */
	public class Enemy 
	{
		private var _content:MovieClip;
		private var _spawnerBounds:Rectangle;
		
		public function Enemy(mc:MovieClip) 
		{
			_content = mc;
			ContentAsserter.assertContent(["_spawner", "foobar"]);
			
		}
		
		
		
	}

}
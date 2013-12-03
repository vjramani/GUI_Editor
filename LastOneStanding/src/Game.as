package  
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class Game extends Sprite 
	{
		
		private var q:Quad;
		
		public function Game() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			q = new Quad(200, 200);
			q.setVertexColor(0, 0x000000);
			q.setVertexColor(1, 0x2C98C0);
			q.setVertexColor(2, 0x0AE28B);
			q.setVertexColor(3, 0xFF8000);
			
			addChild(q);
			
			q.x = (stage.stageWidth - q.width) >> 1;
			q.y = (stage.stageHeight - q.height) >> 1;
		}
		
	}

}
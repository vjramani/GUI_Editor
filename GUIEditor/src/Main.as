package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class Main extends Sprite 
	{
		[Embed(source="../res/fonts/pirulen.ttf", fontName = "Pirulen", mimeType = "application/x-font", embedAsCFF="false")]
		private var embeddedFontPirulen:Class;
		
		public function Main():void 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//addChild(new UITester());
			addChild(new UIEditor());
		}
		
	}
	
}
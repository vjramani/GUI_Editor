package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NativeWindowBoundsEvent;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class UIEditor extends Sprite
	{
		
		public function UIEditor() 
		{
			addEventListener(Event.ADDED_TO_STAGE, InitApplication);
		}
		
		private function InitApplication(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, InitApplication);
			
			stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE, WindowResized);
			stage.nativeWindow.maximize();
		}
		
		private function WindowResized(e:NativeWindowBoundsEvent):void 
		{
			
		}
		
	}

}
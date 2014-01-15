package  
{
	import core.FileLoader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NativeWindowBoundsEvent;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class UIEditor extends Sprite
	{
		private static var EDITOR_UI_URL:String = "res/editorui.xml";
		private var editorInitialized:Boolean = false;
		
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
			if (!editorInitialized)
			{
				FileLoader.Load(EDITOR_UI_URL, LoadEditorUI);
				editorInitialized = true;
			}
		}
		
		private function LoadEditorUI(_data:*):void 
		{
			// Load the editor UI
			
		}
		
		
		
	}

}
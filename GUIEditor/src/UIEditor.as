package  
{
	import core.delta.IUIControlManager;
	import core.delta.UIControlManager;
	import core.FileLoader;
	import core.pandora.ComponentManager;
	import editor.EditorViewport;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.NativeWindowBoundsEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class UIEditor extends Sprite
	{
		private static var EDITOR_UI_URL:String = "res/editorui.xml";
		private var editorInitialized:Boolean = false;
		private var editorUIControlManager:IUIControlManager = null;
		private var layerEditorTarget:Sprite = null;
		private var layerEditorUI:Sprite = null;
		private var editorViewport:EditorViewport = null;
		
		public function UIEditor() 
		{
			addEventListener(Event.ADDED_TO_STAGE, InitApplication);
		}
		
		private function InitApplication(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, InitApplication);
			stage.nativeWindow.addEventListener(Event.CLOSING, WindowClosing);
			
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			//stage.nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE, WindowResized);
			//stage.nativeWindow.maximize();
			WindowResized(null);
		}
		
		private function WindowClosing(e:Event):void 
		{
			// Cleanup here
			if (fileStream) fileStream.close();
			
		}
		
		private function WindowResized(e:NativeWindowBoundsEvent):void 
		{
			if (!editorInitialized)
			{
				FileLoader.Load(EDITOR_UI_URL, LoadEditorUI);
				editorInitialized = true;
			}
			
			graphics.lineStyle(2, 0xFFFFFF);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			
			trace(stage.stageWidth + " x " + stage.stageHeight);
		}
		
		private function LoadEditorUI(_data:*):void 
		{
			layerEditorTarget = new Sprite();
			addChild(layerEditorTarget);
			
			editorViewport = new EditorViewport(layerEditorTarget);
			
			layerEditorUI = new Sprite();
			addChild(layerEditorUI);
			
			var _compManager:ComponentManager = new ComponentManager();
			_compManager.Load(XML(_data));
			
			// Load the editor UI
			editorUIControlManager = UIControlManager.GetUIControlManager();
			editorUIControlManager.Initialize(layerEditorUI, _compManager);
			
			editorUIControlManager.Show("btnLoadFile");
			editorUIControlManager.Show("btnSaveFile");
			
			editorUIControlManager.RegisterEventListener("evtEditorLoadFile", LoadUIFile);
			editorUIControlManager.RegisterEventListener("evtEditorSaveFile", SaveUIFile);
		}
		
		private var fileToEdit:File = null;
		private var fileStream:FileStream = null;
		
		private function LoadUIFile(_obj:String):void 
		{
			trace("Load UI File called");
			fileToEdit = File.applicationDirectory;
			SelectFileToLoad(fileToEdit);
		}
		
		private function SelectFileToLoad(_root:File):void
		{
			var _filter:FileFilter = new FileFilter("Text", "*.xml");
			_root.browseForOpen("Open Component File", new Array(_filter));
			_root.addEventListener(Event.SELECT, FileToOpenSelected);
		}
		private var targetXML:XML = null;
		private function FileToOpenSelected(e:Event):void 
		{
			//trace(fileToEdit.nativePath);
			fileStream = new FileStream();
			fileStream.open(fileToEdit, FileMode.READ);
			
			targetXML = XML(fileStream.readUTFBytes(fileStream.bytesAvailable));
			editorViewport.LoadControls(targetXML);
			
			fileStream.close();
			fileStream = null;
		}
		
		private function SaveUIFile(_obj:String):void 
		{
			if (!fileToEdit) return;
			
			fileStream = new FileStream();
			fileStream.open(fileToEdit, FileMode.WRITE);
			
			fileStream.writeUTFBytes(targetXML.toString());
			fileStream.close();
		}
		
	}

}
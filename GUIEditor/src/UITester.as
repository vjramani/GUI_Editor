package  
{
	import core.delta.IUIControlManager;
	import core.delta.UIControlManager;
	import core.FileLoader;
	import core.pandora.ComponentManager;
	import core.utilities.SingletonClass;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class UITester extends Sprite
	{
		[Embed(source="../res/fonts/pirulen.ttf", fontName = "Pirulen", mimeType = "application/x-font", embedAsCFF="false")]
		private var embeddedFontPirulen:Class;
		
		public function UITester() 
		{
			Init();
		}
		
		private function Init():void
		{
			FileLoader.Load("res/config.xml", ConfigFileLoaded);
		}
		
		private function ConfigFileLoaded(_data:*):void 
		{
			var _compMan:ComponentManager = ComponentManager.GetInstance();
			_compMan.Load(XML(_data));
			
			var _uiMan:IUIControlManager = UIControlManager.GetUIControlManager();
			_uiMan.Initialize(this, _compMan);
			
			_uiMan.Show("popup");
			
			_uiMan.RegisterEventListener("evtYesClicked", PopupYesClicked);
			_uiMan.RegisterEventListener("evtNoClicked", PopupNoClicked);
			
			_uiMan.RegisterEventListener("evtOnLoad", OnProgressBarLoad);
			_uiMan.RegisterEventListener("evtOnComplete", OnProgressBarComplete);
			
			//var _s:Sprite = _compMan.GetObject("popup").GetGraphic();
			//_s.x = _s.y = 100;
			//addChild(_s);
			
			/*
			var _tf:TextFormat = new TextFormat();
			_tf.size = 10;
			_tf.color = 0x000000;
			_tf.font = "Pirulen";
			
			_tf.align = "center";
			var _t:TextField = new TextField();
			_t.defaultTextFormat = _tf;
			_t.x = 0;
			_t.y = 0;
			_t.width = 300;
			_t.height = 400;
			_t.text = "Some Gibbrish Text";
			
			_t.background = true;
			addChild(_t);
			/**/
		}
		
		private var simRatio:Number = 0;
		private function OnProgressBarLoad(_objectId:String):Number 
		{
			simRatio += 0.02;
			return simRatio;
		}
		private function OnProgressBarComplete(_objectId:String):void 
		{
			trace("On Load Complete");
		}
		
		private function PopupYesClicked(_objectId:String):void
		{
			trace("PopupYesClicked " + _objectId);
			UIControlManager.GetUIControlManager().Show("proLoader");
		}
		
		private function PopupNoClicked(_objectId:String):void
		{
			trace("PopupNoClicked "+_objectId);
		}
		
	}

}
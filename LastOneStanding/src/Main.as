package 
{
	import core.delta.Button;
	import core.expresso.Expresso;
	import core.FileLoader;
	import core.pandora.ComponentManager;
	import core.pandora.ComponentObject;
	import core.XMLScriptInterpreter;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class Main extends Sprite 
	{
		[Embed(source="../res/fonts/pirulen.ttf", fontName = "Pirulen", mimeType = "application/x-font", embedAsCFF="false")]
		private var embeddedFontPirulen:Class;
		
		private var starling:Starling;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			/* // Init Starling
			starling = new Starling(Game, stage);
			starling.showStats = true;
			starling.antiAliasing = 1;
			starling.start();
			*/
			
			addEventListener(Event.ADDED_TO_STAGE, Init);
			
			// new to AIR? please read *carefully* the readme.txt files!
		}
		
		private function Init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			FileLoader.Load("res/config.xml", ConfigFileLoaded);
			
		}
		
		private function ConfigFileLoaded(_data:*):void
		{
			//trace(_data);
			//*
			var _compMan:ComponentManager = ComponentManager.GetInstance();
			_compMan.Load(XML(_data));
			
			//var _c:ComponentObject = _compMan.GetObject("btnFirst");
			//var _b:Button = new Button(_c);
			//_b.Activate();
			
			var _s:Sprite = _c.GetGraphic();
			_s.x = _s.y = 100;
			addChild(_s);
			
			//_s.getChildByName("maskEmpty").y += _s.height;
			//_s.getChildByName("maskFull").y += _s.height;
			/**/
			
			//Expresso.Evaluate("4-(2+5*(8-7/2)/15*(2*4-7))");
			
			//ComponentManager.GetInstance().Test();
		}
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}
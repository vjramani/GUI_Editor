package core.delta 
{
	import core.pandora.ComponentManager;
	import core.utilities.SingletonClass;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class UIControlManager extends SingletonClass implements IUIControlManager,IUIEventHandler
	{
		public static function GetUIControlManager():IUIControlManager
		{
			return SingletonClass.GetInstance(UIControlManager) as IUIControlManager;
		}
		public static function GetUIEventHandler():IUIEventHandler
		{
			return SingletonClass.GetInstance(UIControlManager) as IUIEventHandler;
		}
		
		private var uiLayer:Sprite = null;
		private var compManager:ComponentManager = null;
		
		private var controls:Dictionary = new Dictionary();
		private var events:Dictionary = new Dictionary();
		
		public function UIControlManager(_s:*)
		{
			super(_s);
		}
		
		public function Initialize(_uiLayer:Sprite, _compManager:ComponentManager):void
		{
			uiLayer = _uiLayer;
			compManager = _compManager;
			
			InitAllControls();
		}
		
		private function InitAllControls():void
		{
			var _factory:UIControlFactory = SingletonClass.GetInstance(UIControlFactory);
			// Get the root elements fromt the component Manager
			// Loop through all the root elements and then Intantiate all the Controls
			var _elems:Array = compManager.GetElementList();
			var _comp:IUIComponent = null;
			
			for (var i:int = 0; i < _elems.length;i++ )
			{
				_comp = _factory.Create(compManager.GetObject(_elems[i]));
				if (_comp)
				{
					controls[_elems[i]] = _comp;
				}
			}
		}
		
		public function Show(_name:String):Boolean
		{
			if (!_name) return false;
			
			var _control:IUIComponent = controls[_name];
			if (!_control) return false;
			
			uiLayer.addChild(_control.GetGraphicComponent().GetGraphic());
			_control.Activate();
			
			return true;
		}
		
		public function RegisterEventListener(_eventName:String, _callback:Function):void
		{
			events[_eventName] = _callback;
		}
		
		public function UnRegisterEventListener(_eventName:String, _callback:Function):void
		{
			if (events[_eventName] != undefined)
			{
				events[_eventName] = null;
			}
		}
		
		public function FireEvent(_eventName:String, _controlObjectId:String):Number
		{
			if (events[_eventName] != undefined)
			{
				return events[_eventName](_controlObjectId);
			}
			
			return 0;
		}
	}

}

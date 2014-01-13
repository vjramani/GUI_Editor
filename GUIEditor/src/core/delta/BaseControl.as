package core.delta 
{
	import core.pandora.ComponentManager;
	import core.pandora.ComponentObject;
	import core.utilities.SingletonClass;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class BaseControl implements IUIComponent
	{
		protected var graphicComponent:ComponentObject = null;
		private var childControls:Dictionary = null;
		
		public function BaseControl(_cobj:ComponentObject) 
		{
			graphicComponent = _cobj;
			childControls = new Dictionary();
		}
		
		public function Activate():void
		{
			
		}
		
		public function Deactivate():void
		{
			
		}
		
		public function GetGraphicComponent():ComponentObject
		{
			return graphicComponent;
		}
		
		protected final function GetChildControls(_cobj:ComponentObject):void
		{
			var _childComps:Array = _cobj.GetChildren();
			if (_childComps.length <= 0) return;
			
			var _comp:ComponentObject = null;
			var _fact:UIControlFactory = SingletonClass.GetInstance(UIControlFactory);
			var _child:IUIComponent = null;
			
			for (var i:int = 0; i < _childComps.length;i++ )
			{
				_comp = _cobj.GetChildObject(_childComps[i]);
				_child = _fact.Create(_comp);
				if (_child)
				{
					childControls[_childComps[i]] = _child;
				}
			}
		}
		
		protected final function GetChild(_name:String):IUIComponent
		{
			if (!childControls[_name]) return null;
			
			return childControls[_name];
		}
		
		protected final function SendEvent(_eventName:String):Number
		{
			var _ret:Number = UIControlManager.GetUIEventHandler().FireEvent(_eventName, graphicComponent.GetAttribute("id"));
			return _ret;
		}
		
		protected final function GetEvent(_eventName:String):String
		{
			return graphicComponent.GetAttribute(_eventName);
		}
	}

}
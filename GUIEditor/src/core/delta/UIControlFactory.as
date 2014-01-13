package core.delta 
{
	import core.pandora.ComponentObject;
	import core.utilities.SingletonClass;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class UIControlFactory extends SingletonClass
	{
		private static const NAME_BUTTON:String 		= "button";
		private static const NAME_PROGRESSBAR:String 	= "progressbar";
		private static const NAME_POPUP2:String 			= "popup2";
		
		private var registeredClasses:Dictionary = new Dictionary();
		
		public function UIControlFactory(_s:*) 
		{
			super(_s);
			
			InitializeClasses();
		}
		
		private function InitializeClasses():void
		{
			registeredClasses[NAME_BUTTON] 		= Button;
			registeredClasses[NAME_PROGRESSBAR] = ProgressBar;
			registeredClasses[NAME_POPUP2] 		= Popup2;
		}
		
		public function Create(_cobj:ComponentObject):IUIComponent
		{
			var _className:Class = registeredClasses[_cobj.GetClassName()];
			if (!_className) return null;
			
			var _comp:IUIComponent = new _className(_cobj);
			
			return _comp;
		}
	}

}
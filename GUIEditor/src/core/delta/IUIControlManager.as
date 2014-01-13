package core.delta 
{
	import core.pandora.ComponentManager;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public interface IUIControlManager 
	{
		function Initialize(_uiLayer:Sprite, _compManager:ComponentManager):void;
		function Show(_name:String):Boolean;
		function RegisterEventListener(_eventName:String, _callback:Function):void;
		function UnRegisterEventListener(_eventName:String, _callback:Function):void;
	}
	
}
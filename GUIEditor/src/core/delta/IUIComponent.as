package core.delta 
{
	import core.pandora.ComponentObject;
	
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public interface IUIComponent 
	{
		function Activate():void;
		function Deactivate():void;
		function GetGraphicComponent():ComponentObject;
	}
	
}
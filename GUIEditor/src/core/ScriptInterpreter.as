package core 
{
	
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public interface ScriptInterpreter 
	{
		function GetChildCount(root:Object, name:String = null):Number;
		function GetChildNodes(root:Object, name:String = null):Array;
		function GetChild(root:Object, name:String = null):Object;
		function CheckProperty(root:Object, name:String):Boolean;
		function GetPropertyValue(root:Object, name:String):Object;
	}
	
}
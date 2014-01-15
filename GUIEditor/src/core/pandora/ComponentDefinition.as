package core.pandora 
{
	import core.XMLScriptInterpreter;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	internal class ComponentDefinition 
	{
		private var compManagerHandle:ComponentManager = null;
		private var attributes:Dictionary = null;
		private var compClass:ComponentClass = null
		private var compClassName:String = null;
		
		public function ComponentDefinition(_data:XML, _compMan:ComponentManager):void 
		{
			compManagerHandle = _compMan;
			compClassName = XMLScriptInterpreter.GetNodeName(_data);
			attributes = ParseArttibutes(XMLScriptInterpreter.GetAllAttributes(_data));
			
			Resolve();
		}
		
		public function GetClassName():String
		{	
			return compClassName;
		}
		
		public function GetClass():ComponentClass
		{	
			return compClass;
		}
		
		public function GetAttributes():Dictionary
		{
			return attributes;
		}
		
		private function ParseArttibutes(_data:Array):Dictionary
		{
			if (!attributes) attributes = new Dictionary(); 
			if (!_data) return attributes;
			// Get all the attributes and populate the dictionary
			for (var i:int = _data.length - 1; i >= 0; i--)
			{
				attributes[_data[i].name] = _data[i].value;
			}
			
			return attributes;
		}
		
		public function IsResolved():Boolean
		{
			// Check if the component class is available
			return (compClass != null);
		}
		
		public function Resolve():void
		{
			// Recove the class name from the Component Manager
			if (IsResolved()) return;
			compClass = compManagerHandle.GetComponentClass(compClassName);
		}
		
	}

}
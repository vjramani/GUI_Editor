package core 
{
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public final class XMLScriptInterpreter 
	{
		
		public function XMLScriptInterpreter(_s:SingletonBlocker) 
		{
			if (!_s) throw("Invalid instantiation of a static class");
		}
		
		/* INTERFACE core.ScriptInterpreter */
		
		static public function GetChildCount(root:XML, name:String = null):Number 
		{
			return root.children().length();
		}
		
		static public function GetChildNodes(root:XML, name:String = null):Array 
		{
			var _children:XMLList;
			if (name != null) _children = root.child(name);
			else _children = root.children();
			
			if (!_children || _children.length() <= 0) return null;
			
			var _arr:Array = new Array();
			for each(var _child:XML in _children)
			{
				_arr.push(_child);
			}
			
			return _arr;
		}
		
		static public function GetChild(root:XML, name:String = null):Object 
		{
			return null;
		}
		
		static public function CheckProperty(root:XML, name:String):Boolean 
		{
			return false;
		}
		
		static public function GetPropertyValue(root:XML, name:String):Object 
		{
			var _val:String = root.@id;
			if (_val) return _val;
			return null;
		}
		
		static public function GetAllAttributes(root:XML):Array
		{
			// We need this
			var _attributes:XMLList = root.attributes();
			if (_attributes.length() <= 0) return null;
			var _arr:Array = new Array();
			var _obj:Object = null;
			for each(var _attr:XML in _attributes)
			{
				_obj = new Object();
				_obj.name = _attr.localName() as String;
				_obj.value = _attr.toString();
				
				_arr.push(_obj);
			}
			
			return _arr;
		}
		
		static public function GetNodeName(root:XML):String
		{
			return (root.localName() as String);
		}
	}

}
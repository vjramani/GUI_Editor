package core.pandora 
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class ComponentObject 
	{
		public static const ATTRIBUTE_CLASSNAME:String = "className";		
		
		public static function CreateComponentObject(_attribs:Dictionary):ComponentObject
		{
			var _c:ComponentObject = new ComponentObject(new ComponentObjectBlocker());
			_c.SetAttibutes(_attribs);
			
			var _name:String = _c.attributes["id"];
			if (_name) _c.instanceName = _name;
			else _c.instanceName = CreateDefaultObjectName();
			
			return _c;
		}
		
		private static var defaultObjectNameCount:uint = 0;
		private static var defaultObjectName:String = "ComponentObject_";
		private static function CreateDefaultObjectName():String
		{
			return (defaultObjectName + defaultObjectNameCount++);
		}
		
		private var graphic:Sprite;
		private var children:Dictionary;
		private var instanceName:String;
		private var attributes:Dictionary;
		private var parent:ComponentObject;
		
		public function ComponentObject(_s:ComponentObjectBlocker)
		{
			if (!_s) throw("Attempting Direct intiatization of ComponentObject, use CreateComponentObject instead");
			graphic = new Sprite();
			parent = null;
		}
		
		public function AddObject(_obj:ComponentObject):void
		{
			if (!children) children = new Dictionary();
			
			children[_obj.GetName()] = _obj;
			_obj.parent = this;
			_obj.GetGraphic().name = _obj.GetName();
			graphic.addChild(_obj.GetGraphic());
		}
		
		public function GetChildObject(_name:String):ComponentObject
		{
			if (_name && children[_name]) return children[_name];
			return null;
		}
		
		public function GetChildren():Array
		{
			var _names:Array = new Array();
			for (var _name:String in children)
			{
				_names.push(_name);
			}
			
			return _names;
		}
		
		public function GetGraphic():Sprite
		{
			return graphic;
		}
		
		public function GetName():String
		{
			return instanceName;
		}
		
		public function GetAttribute(_name:String):String
		{
			if (attributes[_name] == undefined || attributes[_name] == null) return null;
			return attributes[_name];
		}
		
		public function Attributes():Dictionary
		{
			return attributes;
		}
		
		public function GetClassName():String
		{
			return attributes[ATTRIBUTE_CLASSNAME];
		}
		
		private function SetAttibutes(_attribs:Dictionary):void
		{
			if (attributes) return;
			attributes = new Dictionary();
			for (var _attrib:String in _attribs)
			{
				attributes[_attrib] = _attribs[_attrib];
			}
			
			if (attributes['x']) 		graphic.x 		= attributes['x'];
			if (attributes['y']) 		graphic.y 		= attributes['y'];
			if (attributes['visible']) 	graphic.visible = (attributes['visible']=='true')?true:false;
		}
	}
}
class ComponentObjectBlocker
{
	
}


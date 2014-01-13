package core.pandora 
{
	import core.expresso.Expresso;
	import core.XMLScriptInterpreter;
	import flash.utils.Dictionary;
	import mx.utils.StringUtil;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	internal class ComponentClass
	{	
		private static function ResolveParentAttributes(_childAttribs:Dictionary, _parentAttribs:Dictionary):Dictionary
		{
			var _attribs:Dictionary = new Dictionary();
			var _v:String;
			
			for (var _val:String in _childAttribs)
			{
				_v = _childAttribs[_val];
				_attribs[_val] = _v;
				if (_v.indexOf('$') >= 0) _v = ResolveVariables(_v, _parentAttribs);
				
				// Check if the value is an expression
				if (CheckIfExpression(_v)) _v = "" + Expresso.Evaluate(_v);
				
				_attribs[_val] = _v;
				if (_attribs[_val] == null) throw("Unresolved parent attribute");
			}
			
			return _attribs;
		}
		
		private static function CheckIfExpression(_exp:String):Boolean
		{
			if(	(_exp.indexOf('+') < 0)
			&&	(_exp.indexOf('-') < 0)
			&&	(_exp.indexOf('*') < 0)
			&&	(_exp.indexOf('/') < 0)
			&&	(_exp.indexOf('(') < 0)
			&&	(_exp.indexOf(')') < 0)) return false;
			
			return true;
		}
		
		public static function ResolveVariables(_exp:String, _vars:Dictionary):String
		{
			var _i:int = 0;
			var _vname:String = "";
			while (_i >= 0)
			{
				_i = _exp.indexOf('$');
				if (_i < 0) break; 
				_vname = GetVariableName(_exp, _i);
				if (_vars[_vname] == null || _vars[_vname] == undefined) throw("Invalid parent attribute");
				_exp = _exp.replace('$' + _vname, _vars[_vname]);
			}
			
			return _exp;
		}
		
		private static function GetVariableName(_exp:String, _start:int):String
		{
			var _name:String = "";
			var _i:int = _start+1;
			var _c:String;
			while (_i < _exp.length)
			{
				_c = _exp.charAt(_i++);
				if (StringUtil.isWhitespace(_c) || "+-*/$&".indexOf(_c) >= 0)
				{
					break;
				}
				_name += _c;
			}
			
			return _name;
		}
		
		private static function ResolveDefaultAttributes(_passed:Dictionary, _default:Dictionary):Dictionary
		{
			for (var _attrib:String in _default)
			{
				if (_passed[_attrib] != undefined || _passed[_attrib] != null) continue;
				_passed[_attrib] = _default[_attrib];
			}
			
			return _passed;
		}
		
		private var compDefinition:ComponentDefinition = null;
		private var children:Array = null;
		
		public function ComponentClass(_data:XML)
		{
			// Strip the xml and make the relevant child classes, Get the definition from the configuration class
			if (!_data) throw("Invalid XML data sent to ComponentDefinition");
			
			compDefinition = new ComponentDefinition(_data);
			
			children = new Array();
			ParseChildComponents(_data);
		}
		
		private function ParseChildComponents(_data:XML):void
		{
			var _children:Array = XMLScriptInterpreter.GetChildNodes(_data);
			for (var i:int = 0; i < _children.length; i++)
			{
				children.push(new ComponentDefinition(_children[i]));
			}
		}
		
		public function Resolve():void
		{
			compDefinition.Resolve();
			
			var _childName:String = null;
			
			// Check if the xml has been defined 
			for each(var _child:ComponentDefinition in children)
			{
				_childName = _child.GetClassName() as String;
				// Check if it is defind as a Primitive first
				if (PrimitiveOperations.IsPrimitiveOperation(_childName)) continue;
				_child.Resolve();
			}
		}
		
		
		public function IsResolved():Boolean
		{
			for each(var _child:ComponentDefinition in children)
			{
				if (!_child.IsResolved())
				{
					return false;
				}
			}
			
			return true;
		}
		
		public function CreateComponent(_attr:Dictionary):ComponentObject
		{
			_attr = ResolveDefaultAttributes(_attr, compDefinition.GetAttributes());
			_attr[ComponentObject.ATTRIBUTE_CLASSNAME] = GetClassName();
			var _obj:ComponentObject = ComponentObject.CreateComponentObject(_attr);
			
			var _childCompObj:ComponentObject = null;
			var _attribs:Dictionary = null;
			for each(var _child:ComponentDefinition in children)
			{
				_attribs = ResolveParentAttributes(_child.GetAttributes(), _obj.Attributes());
				
				if (PrimitiveOperations.IsPrimitiveOperation(_child.GetClassName())) PrimitiveOperations.Operate(_obj, _child.GetClassName(), _attribs);
				else {
					_childCompObj = _child.GetClass().CreateComponent(_attribs);
					if (_childCompObj) _obj.AddObject(_childCompObj);
				}
			}
			
			return _obj;
		}
		
		private function AlignObjectToParent(_obj:ComponentObject):void
		{
			var _arr:Array = _obj.GetChildren();
			var _cobj:ComponentObject = null;
			
			for (var i:int = 0; i < _arr.length; i++)
			{
				
			}
		}
		
		public function GetClassName():String
		{
			return compDefinition.GetClassName();
		}
		
		public function GetAttributes():Dictionary
		{
			return compDefinition.GetAttributes();
		}
	}
}
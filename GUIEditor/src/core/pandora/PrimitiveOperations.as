package core.pandora
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	internal class PrimitiveOperations
	{
		static private var primitiveOperations:Dictionary = null;
		
		static public function GetVAlignmentToParent(_obj:DisplayObject, _valign:String="top"):Number
		{
			if (!_obj.parent) throw("GetAlignmentToParent - Object not added to parent");
			
			var _n:Number = 0;
			if (_valign == "middle") _n = (_obj.parent.height - _obj.height) / 2; 
			else if (_valign == "bottom") _n = (_obj.parent.height - _obj.height);
			else if (_valign == "top") _n = 0;
			
			return _n;
		}
		
		static public function GetHAlignmentToParent(_obj:DisplayObject, _halign:String="left"):Number
		{
			if (!_obj.parent) throw("GetAlignmentToParent - Object not added to parent");
			
			var _n:Number = 0;
			if (_halign == "center") _n = (_obj.parent.width - _obj.width) / 2; 
			else if (_halign == "right") _n = (_obj.parent.width - _obj.width);
			else if (_halign == "left") _n = 0;
			
			return _n;
		}
		
		static public function IsPrimitiveOperation(_class:String):Boolean
		{
			if (!_class)
				throw("Null Class String sent to IsPrimitiveOperation");
			
			if (primitiveOperations[_class] == undefined || primitiveOperations[_class] == null)
				return false;
			return true;
		}
		
		static public function Operate(_obj:ComponentObject, _class:String, _attributes:Dictionary):void
		{
			if (!_obj || !_class || !_attributes)
				throw("Invalid Parameter sent to PrimitiveOperations::Operate");
			
			// Resolve parent attributes first _obj being the parent
			primitiveOperations[_class](_obj.GetGraphic(), _attributes);
		}
		
		static public function InitOperations():void
		{
			if (!primitiveOperations)
				primitiveOperations = new Dictionary();
			
			// Register all Primitive functions here
			primitiveOperations["moveTo"] = moveTo;
			primitiveOperations["lineTo"] = lineTo;
			primitiveOperations["beginFill"] = beginFill;
			primitiveOperations["endFill"] = moveTo;
			primitiveOperations["lineStyle"] = lineStyle;
			primitiveOperations["text"] = text;
			primitiveOperations["drawCircle"] = circle;
		}
		
		public function PrimitiveOperations(_s:PrimitivOperationClassBlocker)
		{
			if (!_s)
				throw("Attempting to instantiate Static class PrimitiveOperations");
		}
		
		static private function moveTo(_gra:Sprite, _attr:Dictionary):void
		{
			var _x:Number = (_attr["x"]) ? parseFloat(_attr["x"]) : 0;
			var _y:Number = (_attr["y"]) ? parseFloat(_attr["y"]) : 0;
			_gra.graphics.moveTo(_x, _y);
		}
		
		static private function lineTo(_gra:Sprite, _attr:Dictionary):void
		{
			var _x:Number = (_attr["x"]) ? parseFloat(_attr["x"]) : 0;
			var _y:Number = (_attr["y"]) ? parseFloat(_attr["y"]) : 0;
			_gra.graphics.lineTo(_x, _y);
		}
		
		static private function beginFill(_gra:Sprite, _attr:Dictionary):void
		{
			var _color:uint = (_attr["color"]) ? parseInt(_attr["color"]) : 0xFFFFFF;
			var _alpha:Number = (_attr["alpha"]) ? parseFloat(_attr["alpha"]) : 1;
			_gra.graphics.beginFill(_color, _alpha);
		}
		
		static private function endFill(_gra:Sprite, _attr:Dictionary):void
		{
			_gra.graphics.endFill();
		}
		
		static private function lineStyle(_gra:Sprite, _attr:Dictionary):void
		{
			var _thickness:Number = (!_attr["thickness"] || _attr["thickness"] == "0") ? null : parseFloat(_attr["thickness"]);
			var _color:uint = (_attr["color"]) ? parseInt(_attr["color"]) : 0xFFFFFF;
			var _alpha:Number = (_attr["alpha"]) ? parseFloat(_attr["alpha"]) : 1;
			
			_gra.graphics.lineStyle(_thickness, _color, _alpha);
		}
		
		static private function circle(_gra:Sprite, _attr:Dictionary):void
		{
			var _x:Number = (_attr["x"]) ? parseFloat(_attr["x"]) : 0;
			var _y:Number = (_attr["y"]) ? parseFloat(_attr["y"]) : 0;
			var _r:Number = (_attr["radius"]) ? parseFloat(_attr["radius"]) : 0;
			
			_gra.graphics.drawCircle(_x, _y, _r);
		}
		
		static private function text(_gra:Sprite, _attr:Dictionary):void
		{
			var _x:Number = (_attr["x"]) ? parseFloat(_attr["x"]) : 0;
			var _y:Number = (_attr["y"]) ? parseFloat(_attr["y"]) : 0;
			var _text:String = (_attr["text"]) ? _attr["text"] : "Text";
			var _size:Number = (_attr["size"]) ? parseFloat(_attr["size"]) : 10;
			var _color:uint = (_attr["color"]) ? parseInt(_attr["color"]) : 0xFFFFFF;
			var _font:String = (_attr["font"]) ? _attr["font"] : "Verdana";
			var _bold:String = (_attr["bold"]) ? _attr["bold"] : "false";
			var _italic:String = (_attr["italic"]) ? _attr["italic"] : "false";
			var _wrap:String = (_attr["wrap"]) ? _attr["wrap"] : "false";
			var _txtalign:String = (_attr["txtalign"]) ? _attr["txtalign"] : TextFormatAlign.LEFT;
			var _halign:String = (_attr["halign"]) ? _attr["halign"] : "none";
			var _valign:String = (_attr["valign"]) ? _attr["valign"] : "none";
			var _txtwidth:Number = (_attr["txtwidth"]) ? _attr["txtwidth"] : 100;
			var _txtheight:Number = (_attr["txtheight"]) ? _attr["txtheight"] : 20;
			
			var _tf:TextFormat = new TextFormat();
			_tf.size = _size;
			_tf.color = _color;
			_tf.font = _font;
			_tf.bold = (_bold == "true") ? true : false;
			_tf.italic = (_italic == "true") ? true : false;
			_tf.align = _txtalign;
			var _t:TextField = new TextField();
			_t.defaultTextFormat = _tf;
			_t.x = _x;
			_t.y = _y;
			_t.width = _txtwidth;
			_t.height = _txtheight;
			_t.text = _text;
			_t.wordWrap = (_wrap == "true") ? true : false;
			_t.selectable = false;
			
			_gra.addChild(_t);
			
			if (_halign != "none") _t.x = GetHAlignmentToParent(_t, _halign);
			if (_valign != "none") _t.y = GetVAlignmentToParent(_t, _valign);
			
		}
	}

}

class PrimitivOperationClassBlocker
{

}
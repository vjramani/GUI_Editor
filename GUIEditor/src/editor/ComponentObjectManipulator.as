package editor 
{
	import core.pandora.ComponentObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class ComponentObjectManipulator
	{
		public static function CreateCOManipulator(_obj:ComponentObject, _ev:EditorViewport):ComponentObjectManipulator
		{
			var _com:ComponentObjectManipulator = new ComponentObjectManipulator(new Blocker(), _obj);
			_com.editorViewportRef = _ev;
			_com.Initialize();
			
			return _com;
		}
		
		private var compObject:ComponentObject = null;
		private var editorViewportRef:EditorViewport = null;
		private var highlight:Sprite = null;
		private var children:Array = null;
		
		public function ComponentObjectManipulator(_c:Blocker, _obj:ComponentObject) 
		{
			if (!_c) throw("Invalid initialization of the ComponentObjectManipulator class, use the CreateCOManipulator static call");
			if (!_obj) throw("Invalid ComponentObject parameter");
			
			compObject = _obj;
		}
		
		private function Initialize():void
		{
			highlight = new Sprite();
			CreateHighLightShape(highlight.graphics);
			AddHighLightProperties(compObject.GetGraphic());
			editorViewportRef.AddHightLight(highlight);
		}
		
		private function AddHighLightProperties(_gra:Sprite):void 
		{
			highlight.x = _gra.x;
			highlight.y = _gra.y;
			
			if (compObject.GetParent())
			{
				highlight.x += compObject.GetParent().GetGraphic().x;
				highlight.y += compObject.GetParent().GetGraphic().y;
			}
			
			highlight.alpha = 0.1;
			highlight.addEventListener(MouseEvent.MOUSE_OVER, MouseOver);
			highlight.addEventListener(MouseEvent.MOUSE_OUT, MouseOut);
			highlight.addEventListener(MouseEvent.MOUSE_DOWN, MouseDown);
			highlight.addEventListener(MouseEvent.MOUSE_UP, MouseUp);
			highlight.addEventListener(MouseEvent.MOUSE_MOVE, MouseMove);
			//highlight.addEventListener(MouseEvent.ROLL_OUT, MouseOut);
			highlight.addEventListener(MouseEvent.RIGHT_CLICK, RightClicked);
		}
		
		private function RightClicked(e:MouseEvent):void 
		{
			editorViewportRef.MoveDownHeirarhcy(compObject);
		}
		
		private var mouseHeld:Boolean = false;
		private var startPoint:Point = new Point();
		private var mousePoint:Point = new Point();
		
		private function MouseMove(e:MouseEvent):void 
		{
			if (mouseHeld)
			{
				compObject.GetGraphic().x = highlight.x;
				compObject.GetGraphic().y = highlight.y;
			}
		}
		
		private function MouseUp(e:MouseEvent):void 
		{
			mouseHeld = false;
			highlight.stopDrag();
			
			var _x:Number = highlight.x;
			var _y:Number = highlight.y;
			if (compObject.GetParent())
			{
				_x -= compObject.GetParent().GetGraphic().x;
				_y -= compObject.GetParent().GetGraphic().y;
			}
			editorViewportRef.UpdateValuesFor(this, _x, _y);
		}
		5
		private function MouseDown(e:MouseEvent):void 
		{
			if (highlight.alpha >= 1) {
				mouseHeld = true;
				startPoint.x = highlight.x;
				startPoint.y = highlight.y;
				
				highlight.startDrag();
			}
			else mouseHeld = false;
		}
		
		private function MouseOut(e:MouseEvent):void 
		{
			highlight.alpha = 0;
		}
		
		private function MouseOver(e:MouseEvent):void 
		{
			highlight.alpha = 1;
			//trace(compObject.GetClassName() + " : " + compObject.GetName());
		}
		
		private function CreateHighLightShape(_g:Graphics):void
		{
			var _graphic:Sprite = compObject.GetGraphic();
			var _r:Rectangle = _graphic.getRect(_graphic);
			
			_g.lineStyle(2, 0xFFFF00);
			_g.beginFill(0xFFFFFF, 0.2);
			_g.drawRect(_r.left, _r.top, _r.width, _r.height);
			_g.endFill();
		}
		
		public function GetClassPath():Array
		{
			var _arr:Array = new Array();
			
			var _co:ComponentObject = compObject.GetChildObject("btnNo").GetChildObject("out");
			_arr.push(_co.GetClassName());
			var _c:ComponentObject = _co.GetParent();
			while (_c!=null)
			{
				_arr.push(_c.GetClassName());
				_c = _c.GetParent();
			}
			
			return _arr;
		}
		
		public function GetCompObject():ComponentObject
		{
			return compObject;
		}
	}
}

class Blocker
{
	
}
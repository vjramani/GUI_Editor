package editor 
{
	import core.pandora.ComponentObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
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
			
			// Get all children
			var _cobjs:Array = compObject.GetChildren();
			if (!_cobjs || _cobjs.length <= 0) return;
			
			children = new Array();
			// Parse and add all children
			var _child:ComponentObject = null;
			var _chM:ComponentObjectManipulator = null;
			for (var i:int = 0; i < _cobjs.length; i++)
			{
				_child = compObject.GetChildObject(_cobjs[i]);
				_chM = CreateCOManipulator(_child, editorViewportRef);
				children.push(_chM);
			}
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
		}
		
		private function MouseOut(e:MouseEvent):void 
		{
			highlight.alpha = 0.1;
		}
		
		private function MouseOver(e:MouseEvent):void 
		{
			highlight.alpha = 1;
			
			trace(compObject.GetClassName() + " : " + compObject.GetName());
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
		
	}
}

class Blocker
{
	
}
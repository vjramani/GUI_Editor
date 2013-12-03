package core.delta 
{
	import core.pandora.ComponentManager;
	import core.SingletonBlocker;
	import core.pandora.ComponentObject;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Vijay Venkatramani
	 * 
	 * 
	 * Responds to mouse events and swaps states for over, out and down
	 * 
	 * 
	 * 
	 */
	public class Button implements IUIComponent
	{
		private static const OBJNAME_OUT:String 	= "out";
		private static const OBJNAME_OVER:String 	= "over";
		private static const OBJNAME_DOWN:String 	= "down";
		
		private var objOut:ComponentObject = null;
		private var objOver:ComponentObject = null;
		private var objDown:ComponentObject = null;
		private var objMain:ComponentObject = null;
		private var objState:ComponentObject = null;
		
		public function Button(_cobj:ComponentObject)
		{
			InitFromComponentObject(_cobj);
		}
		
		public function InitFromComponentObject(_cobj:ComponentObject):void
		{
			// Pick up each of the components and assign accordingly
			
			objOut 	= _cobj.GetChildObject(OBJNAME_OUT);
			objOver = _cobj.GetChildObject(OBJNAME_OVER);
			objDown = _cobj.GetChildObject(OBJNAME_DOWN);
			
			if (!objOut || !objOver || !objDown) throw("Button: Invalid Child Object in " + _cobj.GetName());
			
			Hide(objOut);
			Hide(objOver);
			Hide(objDown);
			
			objMain = _cobj;
		}
		
		private function Show(_obj:ComponentObject):void
		{
			_obj.GetGraphic().visible = true;
		}
		private function Hide(_obj:ComponentObject):void
		{
			_obj.GetGraphic().visible = false;
		}
		
		private function SetState(_obj:ComponentObject):void
		{
			if (objState) Hide(objState);
			objState = _obj;
			Show(objState);
		}
		
		private function OnMouseOver(e:MouseEvent):void 
		{
			if (objOut.GetGraphic().visible)
			{
				trace("over");
				SetState(objOver);
			}
		}
		
		private function OnMousePress(e:MouseEvent):void 
		{
			trace("down")
			SetState(objDown);
		}
		
		private function OnMouseClick(e:MouseEvent):void 
		{
			trace("click");
			SetState(objOut);
		}
		
		private function OnMouseOut(e:MouseEvent):void 
		{
			SetState(objOut);
		}
		
		public function Activate():void
		{
			objMain.GetGraphic().addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			objMain.GetGraphic().addEventListener(MouseEvent.ROLL_OUT, OnMouseOut);
			objMain.GetGraphic().addEventListener(MouseEvent.MOUSE_DOWN, OnMousePress);
			objMain.GetGraphic().addEventListener(MouseEvent.MOUSE_UP, OnMouseClick);
			objMain.GetGraphic().addEventListener(MouseEvent.RELEASE_OUTSIDE, OnMouseOut);
			
			SetState(objOut);
		}
		
		public function Deactivate():void
		{
			objMain.GetGraphic().removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			objMain.GetGraphic().removeEventListener(MouseEvent.ROLL_OUT, OnMouseOut);
			objMain.GetGraphic().removeEventListener(MouseEvent.MOUSE_DOWN, OnMousePress);
			objMain.GetGraphic().removeEventListener(MouseEvent.MOUSE_UP, OnMouseClick);
			objMain.GetGraphic().removeEventListener(MouseEvent.RELEASE_OUTSIDE, OnMouseOut);
		}
	}

}




package editor 
{
	import core.pandora.ComponentManager;
	import core.pandora.ComponentObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class EditorViewport 
	{
		private var targetSprite:Sprite = null;
		private var comManager:ComponentManager = null;
		private var rootXML:XML = null;
		
		private var layerComp:Sprite = null;
		private var layerHL:Sprite
		
		private var currCompObject:ComponentObject = null;
		
		public function EditorViewport(_sprite:Sprite) 
		{
			targetSprite = _sprite;
			
			layerComp = new Sprite();
			targetSprite.addChild(layerComp);
			layerHL = new Sprite();
			targetSprite.addChild(layerHL);
		}
		
		public function MoveUpHeirarchy():void 
		{
			//trace("Move Up Heirarchy");
			if (currCompObject)
			{
				currCompObject = currCompObject.GetParent();
				ClearLayer(layerComp);
				ClearLayer(layerHL);
				CreateHandlesFor(currCompObject);
			}
		}
		
		public function MoveDownHeirarhcy(_c:ComponentObject):void
		{
			//trace("Move Down Heirarchy");
			if (!_c) return;
			currCompObject = _c;
			ClearLayer(layerComp);
			ClearLayer(layerHL);
			CreateHandlesFor(currCompObject);
		}
		
		public function LoadControls(_xml:XML):void
		{
			if (comManager) comManager.CleanUp();
			comManager = new ComponentManager();
			comManager.Load(_xml);
			
			rootXML = _xml;
			
			currCompObject = null;
			//CreateHandlesFor(comManager.GetObject("popup"));
			CreateHandlesFor();
		}

		private function CreateHandlesFor(_parent:ComponentObject = null):void
		{	
			var _arr:Array = null;
			if (!_parent) _arr = comManager.GetElementList();
			else _arr = _parent.GetChildren();
			
			var _co:ComponentObject = null;
			
			for (var i:int = 0; i < _arr.length; i++)
			{
				if (_parent) _co = _parent.GetChildObject(_arr[i]);
				else _co = comManager.GetObject(_arr[i]);
				AddComponent(_co);
			}
		}
		
		private function AddComponent(_co:ComponentObject):void
		{
			var _com:ComponentObjectManipulator = ComponentObjectManipulator.CreateCOManipulator(_co, this);
			var _s:Sprite = _co.GetGraphic();
			if (_co.GetParent() != null)
			{
				_s.x += _co.GetParent().GetGraphic().x;
				_s.y += _co.GetParent().GetGraphic().y;
			}
			layerComp.addChild(_s);
		}
		
		public function AddHightLight(_s:Sprite):void
		{
			layerHL.addChild(_s);
		}
		
		public function UpdateValuesFor(_comp:ComponentObjectManipulator, _x:Number, _y:Number):void
		{	
			var _co:ComponentObject = _comp.GetCompObject();
			var _po:ComponentObject = _co.GetParent();
			var _xml:XML = rootXML;
			if (_po)
			{
				// Get the class
				var _list:XMLList = rootXML.child(_po.GetClassName());
				for each(var _c:XML in _list)
				{
					trace(_c.children().length());
					if (_c.children().length() > 0) {
						_xml = _c;
						break;
					}
				}
			}
			
			var _childList:XMLList = _xml.child(_co.GetClassName());
			for each(var _child:XML in _childList)
			{
				if (_child.children().length() > 0) continue;
				if (_childList.length() > 1 && _child.@id != _co.GetAttribute("id")) continue;
				
				_child.@x = _x;
				_child.@y = _y;
				
				return;
			}
		}
		
		private function ClearLayer(_s:Sprite):void
		{
			var _n:int = _s.numChildren;
			if (_n <= 0) return;
			
			while (_n > 0)
			{
				_s.removeChildAt(0);
				_n = _s.numChildren;
			}
		}
	}

}
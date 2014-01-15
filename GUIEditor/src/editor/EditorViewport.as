package editor 
{
	import core.pandora.ComponentManager;
	import core.pandora.ComponentObject;
	import flash.display.Sprite;
	
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
		
		public function EditorViewport(_sprite:Sprite) 
		{
			targetSprite = _sprite;
			
			layerComp = new Sprite();
			targetSprite.addChild(layerComp);
			layerHL = new Sprite();
			targetSprite.addChild(layerHL);
		}
		
		public function LoadControls(_xml:XML):void
		{
			if (comManager) comManager.CleanUp();
			comManager = new ComponentManager();
			comManager.Load(_xml);
			
			rootXML = _xml;
			
			var _arr:Array = comManager.GetElementList();
			var _co:ComponentObject = null;
			for (var i:int = 0; i < _arr.length; i++)
			{
				_co = comManager.GetObject(_arr[i]);
				AddComponent(_co);
			}
			
		}
		
		private function AddComponent(_co:ComponentObject):void
		{
			var _com:ComponentObjectManipulator = ComponentObjectManipulator.CreateCOManipulator(_co, this);
			layerComp.addChild(_co.GetGraphic());
		}
		
		public function AddHightLight(_s:Sprite):void
		{
			layerHL.addChild(_s);
		}
		
	}

}
package editor 
{
	import core.pandora.ComponentManager;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class EditorViewport 
	{
		private var targetSprite:Sprite = null;
		private var comManager:ComponentManager = null;
		
		public function EditorViewport(_sprite:Sprite) 
		{
			targetSprite = _sprite;
		}
		
		public function LoadControls(_xml:XML):void
		{
			if (comManager) comManager.CleanUp();
			comManager = new ComponentManager();
			comManager.Load(_xml);
			
			targetSprite.addChild(comManager.GetObject("proLoader").GetGraphic());
		}
		
	}

}
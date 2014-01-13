package core.delta 
{
	import core.pandora.ComponentObject;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class Popup2 extends BaseControl
	{
		
		private var btnYes:Button = null;
		private var btnNo:Button = null;
		
		public function Popup2(_cobj:ComponentObject)
		{
			super(_cobj);
			InitFromComponentObject(_cobj);
		}
		
		public function InitFromComponentObject(_cobj:ComponentObject):void
		{
			GetChildControls(_cobj);
			
			btnYes = GetChild("btnYes") as Button;
			btnNo = GetChild("btnNo") as Button;
		}
		
		public override function Activate():void
		{
			btnNo.Activate();
			btnYes.Activate();
		}
		
	}

}
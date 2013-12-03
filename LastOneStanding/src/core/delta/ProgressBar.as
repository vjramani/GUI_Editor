package core.delta 
{
	import core.pandora.ComponentObject;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class ProgressBar implements IUIComponent
	{
		private static const OBJNAME_BG:String 		= "empty";
		private static const OBJNAME_FILL:String 	= "full";
		private static const OBJNAME_HEAD:String 	= "head";
		private static const OBJNAME_MASK:String 	= "maskFull";
		
		private var objBg:ComponentObject = null;
		private var objFill:ComponentObject = null;
		private var objHead:ComponentObject = null;
		private var objMask:ComponentObject = null;
		
		public function ProgressBar(_cobj:ComponentObject) 
		{
			InitFromComponentObject(_cobj);
		}
		
		private function InitFromComponentObject(cobj:ComponentObject):void 
		{
			objBg 	= _cobj.GetChildObject(OBJNAME_OUT);
			objFill = _cobj.GetChildObject(OBJNAME_OVER);
			objHead = _cobj.GetChildObject(OBJNAME_DOWN);
			objMask = _cobj.GetChildObject(OBJNAME_DOWN);
		}
		
	}

}
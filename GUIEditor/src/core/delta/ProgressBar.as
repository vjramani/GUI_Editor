package core.delta 
{
	import core.pandora.ComponentObject;
	import flash.events.TimerEvent;
	import flash.utils.SetIntervalTimer;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class ProgressBar extends BaseControl
	{
		private static const OBJNAME_BG:String 			= "empty";
		private static const OBJNAME_FILL:String 		= "full";
		private static const OBJNAME_HEAD:String 		= "head";
		private static const OBJNAME_MASK_FULL:String 	= "maskFull";
		private static const OBJNAME_MASK_EMPTY:String 	= "maskEmpty";
		private static const EVTNAME_LOAD:String 		= "eventLoad";
		private static const EVTNAME_COMPLETE:String 	= "eventComplete";
		
		private static const CALLBACK_RATE:Number = 500;
		
		private var objBg:ComponentObject 			= null;
		private var objFill:ComponentObject 		= null;
		private var objHead:ComponentObject 		= null;
		private var objFullMask:ComponentObject 	= null;
		
		private var width:Number = 10;
		private var callbackTimer:Timer = null;
		
		public function ProgressBar(_cobj:ComponentObject) 
		{
			super(_cobj);
			InitFromComponentObject(_cobj);
		}
		
		private function InitFromComponentObject(_cobj:ComponentObject):void 
		{
			objBg 			= _cobj.GetChildObject(OBJNAME_BG);
			objFill 		= _cobj.GetChildObject(OBJNAME_FILL);
			objHead 		= _cobj.GetChildObject(OBJNAME_HEAD);
			objFullMask 	= _cobj.GetChildObject(OBJNAME_MASK_FULL);
			
			objFill.GetGraphic().mask = objFullMask.GetGraphic();
			objFullMask.GetGraphic().scaleX = 0;
			
			width = parseFloat(_cobj.GetAttribute("width"));
		}
		
		private function Progress(_ratio:Number):void
		{
			objHead.GetGraphic().x = width * _ratio;
			objFullMask.GetGraphic().scaleX = _ratio;
			
			if (_ratio >= 1)
			{
				RemoveCallBackTimer();
				SendEvent(GetEvent(EVTNAME_COMPLETE));
			}
		}
		
		private function AddCallbackTimer():void
		{
			if (!callbackTimer) {
				callbackTimer = new Timer(CALLBACK_RATE, 1);
				callbackTimer.addEventListener(TimerEvent.TIMER, CallbackTimerEvent);
				callbackTimer.start();
			}
		}
		
		private function RemoveCallBackTimer():void
		{
			if (callbackTimer)
			{
				callbackTimer.stop();
				callbackTimer.removeEventListener(TimerEvent.TIMER, CallbackTimerEvent);
				callbackTimer = null;
			}
		}
		
		public override function Activate():void
		{
			Progress(0);
			AddCallbackTimer();
		}
		
		public override function Deactivate():void
		{
			RemoveCallBackTimer();
		}
		
		private function CallbackTimerEvent(e:TimerEvent):void 
		{
			Progress(SendEvent(GetEvent(EVTNAME_LOAD)));
			
			if (callbackTimer)
			{
				callbackTimer.reset();
				callbackTimer.start();
			}
		}
	}

}
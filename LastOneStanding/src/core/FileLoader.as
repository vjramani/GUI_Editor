package core 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 * 
	 * Should be able to load XML files, JSON files, Text files, Binary files, Image and other File formats
	 * 
	 * Have to put in listeners for Progress and Errors
	 * 
	 */
	public class FileLoader 
	{
		
		private static var callBackDictionary:Dictionary = null; 
		
		public function FileLoader(_s:SingletonBlocker)
		{
			if (!_s) throw("Invalid instantiation of a static class");
		}
		
		static public function Load(fileName:String, callBack:Function):void
		{
			if (callBack == null) throw ("Invalid callback function in Load");
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, onLoaded);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			
			urlLoader.load(new URLRequest(fileName));
			
			// Add Callback function to Dictionary
			if (!callBackDictionary) callBackDictionary = new Dictionary();
			callBackDictionary[urlLoader] = callBack;
		}
		
		static private function onIOError(e:IOErrorEvent):void 
		{
			//trace("FileLoader I/O Error Event " + e.toString());
			throw("FileLoader I/O Error Event "+ e.toString());
		}
		
		static private function onLoaded(e:Event):void
		{
			callBackDictionary[e.target](e.target.data);
			delete callBackDictionary[e.target];
		}
	}

}
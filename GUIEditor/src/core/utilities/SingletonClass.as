package core.utilities 
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class SingletonClass 
	{
		private static var instances:Dictionary = new Dictionary();
		
		public static function GetInstance(_c:Class):*
		{
			var _name:String = getQualifiedClassName(_c);
			
			if (instances[_name] == undefined || instances[_name] == null)
			{
				instances[_name] = new _c(Blocker); 
			}
			
			return instances[_name];
		}
		
		public function SingletonClass(_s:*) 
		{
			if (_s != Blocker) throw("Attempting to Instantiate a Singleton Class, use SingletonClass.GetInstance(<className>)");
		}
		
		private function GetClassName():String
		{
			var _s:String = getQualifiedClassName(this);
			return _s;
		}
		
	}
}

class Blocker
{
	
}
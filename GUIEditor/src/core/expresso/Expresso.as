package core.expresso 
{
	import flash.utils.Dictionary;
	import mx.utils.StringUtil;
	/**
	 * ...
	 * @author Vijay Venkatramani
	 */
	public class Expresso 
	{
		static private var valStack:Array = new Array();
		static private const opHeirarchy:String = "-+*/";
		
		static public function Evaluate(_exp:String):Number
		{
			var _postFixExp:String = InfixToPostFix(_exp);
			//trace(_exp);
			//trace(_postFixExp);
			//trace(EvaluatePostFix(_postFixExp));
			
			return EvaluatePostFix(_postFixExp);
		}
		
		static private function InfixToPostFix(_exp:String):String
		{
			var _strInfix:String = "";
			var _ch:String = "";
			var _i:int = 0;
			var opStack:Array = new Array();
			
			while (_i < _exp.length)
			{
				_ch = _exp.charAt(_i++);
				// If the character is a whitespace char ignore
				if (StringUtil.isWhitespace(_ch)) continue;
				// if the character is a number push it through
				if ((_ch >= '0' && _ch <= '9') || _ch == '.')
				{
					_strInfix += _ch;
					continue;
				}
				
				if (_ch == '(')
				{
					opStack.push(_ch);
					continue;
				}
				
				// If the character is an operator push it in the stack
				var _opindex:int = opHeirarchy.indexOf(_ch);
				if(_opindex >= 0)
				{
					if (_strInfix.length <= 0 || _strInfix.charAt(_strInfix.length - 1) == '(') _strInfix += ' 0';
					_strInfix += ' ';
					// check if the character in the opstack is of a higher heirarchy
					if (opStack.length > 0)
					{
						while(opHeirarchy.indexOf(opStack[opStack.length - 1]) > _opindex)
						{
							_strInfix += opStack.pop() + ' ';
						}
					}
					opStack.push(_ch);
					continue;
				}
				// If the char is a ')' pop the operator stack till we reach a '('
				if (_ch == ')')
				{
					var _op:String = opStack.pop();
					while (_op != '(' && opStack.length > 0)
					{
						_strInfix += ' ' + _op;
						_op = opStack.pop();
					}
					
					continue;
				}
			}
			
			while (opStack.length > 0)
			{
				_ch = opStack.pop();
				if (_ch == '(') continue;
				_strInfix += ' ' + _ch;
			}
			
			return _strInfix;
		}
		
		static private function EvaluatePostFix(_exp:String):Number
		{
			var _opStack:Array = new Array();
			var _i:int = 0;
			var _ch:String = "";
			var _op:String = "";
			
			while (_i < _exp.length)
			{
				_ch = _exp.charAt(_i++);
				if (opHeirarchy.indexOf(_ch) < 0)
				{
					if (_ch == ' ')
					{
						if (_op.length > 0)
						{
							_opStack.push(parseFloat(_op));
							_op = "";
						}
					}
					else
					{
						_op += _ch;
					}
				}
				else
				{
					_opStack.push(Operate(_ch, _opStack.pop(), _opStack.pop()));
				}
			}
			
			
			return _opStack.pop();
		}
		
		static private function Operate(_op:String, _p1:Number, _p2:Number):Number
		{
			switch(_op)
			{
				case '+': return (_p2 + _p1);
				case '-': return (_p2 - _p1);
				case '*': return (_p2 * _p1);
				case '/': return (_p2 / _p1);
				
				default: throw("Invalid operator");
			}
			
			return 0;
		}
		
		
		public function Expresso(_s:StaticBlocker) 
		{
			if (!_s) throw("Initialization of static class - Expresso");
		}
		
	}

}

class StaticBlocker
{
	
}
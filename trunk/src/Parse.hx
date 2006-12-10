
import ParseError;

enum Token {
	Fim;
	Nulo;
	Numero;
	Funcao;
	Operacao;
	Parenteses;
}

class Parse
{
	public var pos:Int;
	public var exp:String;
	public var tok:Token;
	public var tok_exp:String;
	public var result:Float;
	public var tok_beg:Int;
	
	public function new( e:String ) {
		pos = 0;
		exp = e;
		tok = Nulo;
		tok_beg = 0;
		
		getNextToken("[ main ]");
		result = soma();
		if( tok != Fim ) throw new ParseError(Syntax, [tok_beg, pos]);
	}
	
	public function soma():Float {
		var r = multiplica();
		while( match(tok_exp, "+-") ) {
			var c = tok_exp;
			getNextToken("[ soma ]");
			var r2 = multiplica();
			switch( c ) {
				case "+" : r += r2;
				case "-" : r -= r2;
			}
		}
		return r;
	}
	
	public function multiplica():Float {
		var r = expoente();
		while( match(tok_exp, "*/") ) {
			var c = tok_exp;
			getNextToken("[ mult ]");
			var r2 = expoente();
			switch( c ) {
				case "*" : r *= r2;
				case "/" :
					if(r2 == 0) {
						trace("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"+tok_beg+"  "+pos);
						throw new ParseError(DivByZero, [tok_beg, pos]);
					} else {
						r /= r2;
					}
			}
		}
		return r;
	}
	
	public function expoente():Float {
		var r = unario();
		while( tok_exp == "^" ) {
			getNextToken("[ expo ]");
			var r2 = unario();
			r = Math.pow(r, r2);
		}
		return r;
	}
	
	public function unario():Float {
		var op = "";
		if( tok == Operacao && match(tok_exp, "+-") ) {
			op = tok_exp;
			getNextToken("[unario]");
		}
		var r = parenteses();
		if(op == "-")
			return -r;
		return r;
	}
	
	public function parenteses():Float {
		var r;
		if( tok == Parenteses ) {
			getNextToken("[   (  ]");
			r = soma();
			if(tok != Parenteses) throw new ParseError(WrongParentheses, [tok_beg, pos]);
			getNextToken("[   )  ]");
		} else
		if( tok == Funcao ) {
			var f = tok_exp;
			getNextToken("[ func ]");
			var tmp = parenteses();
			r = handleFunction( f, tmp );
		} else {
			r = numero();
		}
		return r;
	}
	
	public function numero():Float {
		var r;
		switch( tok ) {
			case Numero   : r = Std.parseFloat( tok_exp );
							getNextToken("[numero]");
			case Operacao : r = unario();
			default       : throw new ParseError(Syntax, [tok_beg, pos]);
		}
		return r;
	}
	
	public function handleFunction(func:String, param:Float):Float {
		return switch( func ) {
			case "sin" : Math.sin(param);
			case "cos" : Math.cos(param);
			case "tan" : Math.tan(param);
			case "asin" : Math.asin(param);
			case "acos" : Math.acos(param);
			case "atan" : Math.atan(param);
			case "exp"  : Math.exp(param);
			case "ln"  : Math.log(param);
			case "foo"  : (new Parse(param+"*2")).result;
		}
	}
	
	public function getNextToken(?p:String):Int {
		tok_exp = "";
		if(pos == exp.length) {
			tok = Fim;
			return -1;
		}
		var c = exp.charAt( pos );
		if( match(c, "()") ) {
			tok = Parenteses; pos++;
		} else {
			tok_beg = pos;
			if( match(c, "0123456789.") ) {
				tok_exp = c;
				while(match(exp.charAt(++pos), "0123456789.")) {
					tok_exp += exp.charAt(pos);
				}
				tok = Numero;
			} else
			if( match(c, "+-*/^") ) {
				tok_exp = c;
				tok = Operacao; pos++;
			} else
			if( isChar(c) ) {
				tok_exp = c;
				while( isChar(exp.charAt(++pos)) ) {
					tok_exp += exp.charAt(pos);
				}
				tok = Funcao;
			}
		}
		toString(p);
		return 0;
	}
	
	public function match(str:String, inside:String):Bool {
		if(inside.indexOf(str) == -1 || str == "")
			return false;
		return true;
	}
	
	public function isChar( str:String ):Bool {
		var c = str.charCodeAt(0);
		if( c >= 97 && c <= 122 )
			return true;
		return false;
	}
	
	public function toString(?p:String):Void {
		/*if(p==null) p="";
		trace(
			p + "\t"  +
			"{pos: "  +pos+
			", exp: " +exp+
			", tok: " +tok+
			", tok_exp: "+tok_exp+"}"
		);*/
	}
}

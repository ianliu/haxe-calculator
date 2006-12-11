
enum ErrorType {
	Syntax;
	DivByZero;
	WrongParentheses;
}

class ParseError
{
	public var message  :String;
	public var interval:Array<Int>;
	public var errorType:ErrorType;
	
	public function new(errorType:ErrorType, interval:Array<Int>) {
		this.interval = interval;
		this.errorType = errorType;
		this.message   = switch( errorType ) {
			case Syntax : "Syntax error";
			case DivByZero : "Division by zero";
			case WrongParentheses : "Missing parentheses";
		}
	}
}
